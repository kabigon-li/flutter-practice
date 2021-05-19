import 'dart:io';

import 'package:flutter/material.dart';

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
        leading:GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          SizedBox(
            height: 30,
            width: 70,
            child: Center(
              child: ElevatedButton(
                child: Text(
                  'send',
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
      body: Container(
        child: Column(
          children: [
            //入力枠
            textfild(context),

            SizedBox(height: 30),

            //写真投稿枠
            Image.file(
              widget.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget textfild(BuildContext context) {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 100,
          width: size.width,
          child: ColoredBox(
            color: Colors.grey[200],
            child: Column(
              children: [
                //textfild
                SizedBox(
                  height: 100,
                  width: size.width * .9,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
