import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';

import 'package:wechat_like_memo/model/user.dart';

import 'package:wechat_like_memo/pages/timelineInputPage.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';

import 'package:wechat_like_memo/tab/timeLine_notifier.dart';
import 'package:wechat_like_memo/model/timeline.dart';
import 'package:wechat_like_memo/tab/timeLine_notifier.dart';
import 'package:wechat_like_memo/tab/timeLine_notifier.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage(
    this.userNew,
  );

  final User userNew;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Notifier作成
      create: (_) => TimeLinePageNotifier(
        context: context,
      ),
      child: _TimeLine(),
    );
  }
}

class _TimeLine extends StatelessWidget {
  @override
  Widget build(context) {
    final notifier = Provider.of<TimeLinePageNotifier>(context, listen: false);
    final timelineProvider = Provider.of<TimelineProvider>(context);
     final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: MediaQuery.of(context).size.width,
        centerTitle: true,
        backgroundColor: Color.fromRGBO(201, 218, 228, 1),
        actions: [
          // 发朋友圈按钮
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.add_a_photo,
                  color: Colors.grey,
                  size: 45,
                ),
              ),
              onTap: () {
                showPictureUpdateSheet(context);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // timeline
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                itemCount: timelineProvider.timelineList.length,
                itemBuilder: (BuildContext context, int index) {
                  return timeline(timelineProvider.timelineList[index],
                      notifier.image, context, userProvider
                            .userList[index],);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 上弹窗口
  showPictureUpdateSheet(BuildContext context) {
    final timelineProvider =
        Provider.of<TimelineProvider>(context, listen: false);
    final notifier = Provider.of<TimeLinePageNotifier>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: SizedBox(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Text(
                  'take a picture',
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
                    await notifier.getImage();

                    //　timelintInputにpush、image渡す
                    TimeLine timelineNow = TimeLine(
                      id: timelineProvider.timelineList.length,
                      content: notifier.text,
                      imagePath: notifier.image.path,
                    );

                    // 切换画面后，下弹拦收起
                    Navigator.of(context).pop();

                    // 只有在选择了照片时，向下一个页面移动
                    if (notifier.image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimelineInputPage(
                            image: notifier.image, //次のクラスに渡す
                            timelineNew: timelineNow,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'select from album',
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
                    'return',
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
    TimeLine timelineNew,
    File image,
    BuildContext context,
    User userNew,
  ) {
    final userProvider = Provider.of<UserProvider>(context);
    final timelineProvider = Provider.of<TimelineProvider>(context);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          //color: Colors.yellow[50],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  // 头像
                  //userProvider.getFirstUser().userImage != null

                  _buildUserIconImage(
                context,
                userNew,
              ),
                      //  ClipRRect(
                      //     borderRadius: BorderRadius.circular(10),
                      //     child: Image.memory(
                      //       base64Decode(
                      //         userProvider.getFirstUser().userImage,
                      //       ),
                      //       height: 50,
                      //       width: 50,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      //image为空时显示空
                      // : Icon(
                      //     Icons.account_circle,
                      //     size: 60,
                      //   ),

                  // 用户名
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      userProvider.getFirstUser().userName,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'iconfont',
                      ),
                    ),
                  ),
                ],
              ),

              // 配文
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  //height: 100,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      timelineNew.content,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),

              //朋友圈图片
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

              // 删除按钮等
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: GestureDetector(
                    onTap: () {
                      timelineProvider.deleteTimeline(timelineNew.id);
                      databaseProvider.deleteTimeLine(timelineNew.id);
                    },
                    child: Icon(
                      Icons.delete_outline,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserIconImage(
    BuildContext context,
    User userNew,
  ) {
    final notifier = Provider.of<TimeLinePageNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: MaterialButton(
        onPressed: () {
          notifier.updateUserImage(userNew);
          //点击图片后更新头像
          //notifier.updateUserImage(userNew);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          //データベース中の画像使う時だけ書くSQliteだけ
          child: Image.memory(
            base64Decode(userNew.userImage),
            gaplessPlayback: true,
            fit: BoxFit.cover,
            height: 50,
            width: 50,
          ),
        ),
      ),
    );
  }

 
}
