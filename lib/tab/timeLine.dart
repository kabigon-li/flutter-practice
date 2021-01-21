import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/timeline.dart';
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

  Widget build(BuildContext context) {
    final timelineProvider = Provider.of<TimelineProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: MediaQuery.of(context).size.width,
        centerTitle: true,
        backgroundColor: Colors.green[200],
        // leading: Image.asset(
        //   'image/kabi.jpeg',
        //   width: MediaQuery.of(context).size.width,
        //   //height: 30,
        //   //fit:BoxFit.fitWidth,

        // ),
      ),
      body: Container(
        child: Column(
          children: [
            ListView.builder(
              //physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true, // 高さ関連のエラーが出たら、使う
              itemCount: timelineProvider.timelineList.length,
              itemBuilder: (BuildContext context, int index) {
                return timeline(
                  timelineProvider.timelineList[index],
                );
              },
            ),
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
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  '写真を撮る',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 15),
                Text(
                  'アルバムから選択',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 15),
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
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);

    return Scrollbar(
      child: Column(
        children: [
          GestureDetector(
            child: Card(
              child: Text(text),
            ),
            onTap: () {
              timelineProvider.addTimeline(timelineNew);
            },
          ),
        ],
      ),
    );
  }
}
