import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/Utility/utility.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/timeline.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';

class TimelineInputPage extends StatefulWidget {
  TimelineInputPage({
    this.image, //class受け取る
    this.timelineNew,
  });

  final File image;
  final TimeLine timelineNew;

  @override
  _TimelineInputPageState createState() => _TimelineInputPageState();
}

class _TimelineInputPageState extends State<TimelineInputPage> {
  String text = '';
  String fileName;
  String imageString;
  final picker = ImagePicker();
  File _image;
  Image imageIcon;

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Center(
              child: ElevatedButton(
                child: Text(
                  'send',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(130, 176, 104, 1),
                ),
                onPressed: () {
                  fileName = basename(widget.image.path);
                  imageString =
                      Utility.base64String(widget.image.readAsBytesSync());
                  final databaseProvider =
                      Provider.of<DataBaseProvider>(context, listen: false);

                  // //クタスの実体化、Todoをtodoに代入
                  TimeLine timelineNow = TimeLine(
                    id: timelineProvider.timelineList.length,
                    content: text,
                    imagePath: imageString,
                  );

                  // 新しいtimelineをproviderに追加する
                  timelineProvider.addTimeline(timelineNow);

                  databaseProvider.insertTimeLine(
                    // datebase and todo渡す
                    timeLine: timelineNow,
                  );

                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: [
              //入力枠
              textfild(context),

              SizedBox(height: 30),

              //写真投稿枠
              Image.file(
                widget.image,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textfild(BuildContext context) {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 20,right:10),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 100,
          width: size.width * .8,
          child: ColoredBox(
            color: Colors.grey[200],
            child: Column(
              children: [
                //textfild
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    height: 93,
                    width: size.width * .78,
                    child: ColoredBox(
                      color: Colors.white,
                      child: TextField(
                        maxLines: 20,
                        onChanged: (String text) {
                          chatbox(text);
                        },
                        decoration: InputDecoration(
                          hintText: 'Say something...',
                          contentPadding: const EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  iconImageField() {
    return InkWell(
      onTap: () async {
        // 点按”アルバムから選択”按钮后，获取相册照片
        await getImage();

        //只有在选择了照片时，向下一个页面移动
        if (_image != null) {
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.file(
                _image,
              ),
            ),
          );
        }
      },
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              ),
          child: _image == null
              ? Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: SizedBox(
                    height: 60,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Color.fromRGBO(124, 166, 221, 1),
                        size: 50,
                      ),
                    ),
                  ),
              )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _image,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
