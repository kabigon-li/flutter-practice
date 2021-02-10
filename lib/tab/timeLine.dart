import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/timeline.dart';
import 'package:wechat_like_memo/pages/timelineInputPage.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';

class TimeLine extends StatefulWidget {
  //TimeLine({Key key}) : super(key: key);
//   Timeline({
//  this.image,
//  this.idtext,
//   });
//   final File image;
//   final String idtext;

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  String text = '';

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // 写真取得する（获取照片）
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: MediaQuery.of(context).size.width,
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // 追加icon
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey,
                      size: 33,
                    ),
                  ),
                  onTap: () {
                    showPictureUpdateSheet();
                  },
                ),
              ),

              // timeline
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                itemCount: timelineProvider.timelineList.length,
                itemBuilder: (BuildContext context, int index) {
                  return timeline(
                    timelineProvider.timelineList[index],
                  );
                },
              ),

              //投稿内容追加アイコン
            ],
          ),
        ),
      ),
    );
  }

  showPictureUpdateSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final timelineProvider = Provider.of<TimelineProvider>(context);
        return Container(
          color: Colors.white,
          child: SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  '写真を撮る',
                  style: TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                ),
                //SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    // 点按”アルバムから選択”按钮后，获取相册照片
                    await getImage();

                    //　timelintInputにpush、image渡す
                    Timeline timelineNow = Timeline(
                      id: timelineProvider.timelineList.length,
                      content: text,
                      imagePath: _image.path,
                    );

                    // 切换画面后，下弹拦收起
                    Navigator.of(context).pop();

                    // 只有在选择了照片时，向下一个页面移动
                    if (_image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimelineInputPage(
                            image: _image, //次のクラスに渡す
                            timelineNew: timelineNow,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'アルバムから選択',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 0.2,
                    color: Colors.grey,
                  ),
                ),
                //SizedBox(height: 15),

                GestureDetector(
                  child: Text(
                    '取り消し',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget timeline(
    Timeline timelineNew,
   
  ) {
    //final timelineProvider = Provider.of<TimelineProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          //color: Colors.yellow[50],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // ID icon
                  //  widget._image != null
                  //     ? ClipOval(
                  //         child: Image.file(
                  //           widget.image,
                  //           height: 50,
                  //           width: 50,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       )
                  //     //image为空时显示空
                  //     : Container(),

                  // ID name
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'ID count',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cursive',
                      ),
                    ),
                  ),
                ],
              ),

              // CopyInputPageText
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  //height: 100,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      timelineNew.content,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.memory(
                      base64Decode(timelineNew.imagePath),
                      height: 250,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
