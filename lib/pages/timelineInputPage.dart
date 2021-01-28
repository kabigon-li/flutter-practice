import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/timeline.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';

class TimelineInputPage extends StatefulWidget {
  TimelineInputPage({
    this.image, //class受け取る
    this.timelineNew,
  });

  final File image;
  final Timeline timelineNew;

  @override
  _TimelineInputPageState createState() => _TimelineInputPageState();
}

class _TimelineInputPageState extends State<TimelineInputPage> {
  String text = '';

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: SizedBox(
                width: 80,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    '戻る',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 20,
              width: 50,
              child: ColoredBox(
                color: Colors.greenAccent,
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 60,
                    child: RaisedButton(
                      child: Text('発表'),
                      color: Colors.blueGrey,
                      onPressed: () {
                        //クタスの実体化、Todoをtodoに代入
                        Timeline timelineNow = Timeline(
                          id: timelineProvider.timelineList.length,
                          content: text,
                        );

                        // 新しいtimelineをproviderに追加する
                        timelineProvider.addTimeline(timelineNow);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            //入力枠
            textfild(),

            //写真投稿枠
            Image.file(
              widget.image,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  Widget textfild() {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 60,
          width: size.width,
          child: ColoredBox(
            color: Colors.grey[200],
            child: Column(
              children: [
                //textfild
                SizedBox(
                  height: 50,
                  //width: size.width * .7,
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
