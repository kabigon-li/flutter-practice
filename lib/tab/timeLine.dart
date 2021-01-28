import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/timeline.dart';
import 'package:wechat_like_memo/pages/timelineInputPage.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key key}) : super(key: key);

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
      body: Container(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true, // 高さ関連のエラーが出たら、使う
              itemCount: timelineProvider.timelineList.length,
              itemBuilder: (BuildContext context, int index) {
                return timeline(
                  timelineProvider.timelineList[index],
                );
              },
            ),

            //投稿内容追加アイコン
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
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
          ],
        ),
      ),
    );
  }

  showPictureUpdateSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
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
                    await getImage();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimelineInputPage(
                          image: _image, //次のクラスに渡す
                        ),
                      ),
                    );
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
                Text(
                  '取り消し',
                  style: TextStyle(fontSize: 16),
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
    final timelineProvider = Provider.of<TimelineProvider>(context);

    return Scrollbar(
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(children: [
                ClipOval(
                  child: Image.file(
                    _image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                ),

                //ID name
                Text(
                  " ID name",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cursive',
                  ),
                ),

                //CopyInputPageText
                Text(
                  text, //?わからない
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //CopyInputPageImage
                Image.file(_image),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
