import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wechat_like_memo/components/common_simple_dialog.dart';
import 'package:wechat_like_memo/constant/constants.dart';

import 'package:wechat_like_memo/model/user.dart';

import 'package:wechat_like_memo/pages/timelineInputPage.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/font_size_provider.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';

import 'package:wechat_like_memo/tab/timeLine_notifier.dart';
import 'package:wechat_like_memo/model/timeline.dart';
import 'package:wechat_like_memo/tab/todotoday.dart';

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
     final colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leadingWidth: MediaQuery.of(context).size.width,
        centerTitle: true,
        backgroundColor:  colorList[colorThemeProvider.selectedColorNumber ?? 4],
        actions: [
          // 发朋友圈按钮
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 25,
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
                  return timeline(
                    timelineProvider.timelineList[index],
                    notifier.image,
                    context,
                    userProvider.userList[index],
                  );
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
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: userProvider.getFirstUser().userImage != null
                        ? buildUserIconImage(
                            context,
                            userNew,
                          )
                        : Icon(
                            Icons.account_circle,
                            size: 60,
                            color: Colors.black12,
                          ),
                  ),
                ),
                SizedBox(
                  width: 270,
                  child: ListTile(
                    // 用户名
                    title: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        userProvider.getFirstUser().userName,
                        style: TextStyle(
                          fontSize: fontSizeProvider.fontSize,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'iconfont',
                        ),
                      ),
                    ),

                    // 配文
                    subtitle: Text(
                      timelineNew.content,
                      style: TextStyle(fontSize: fontSizeProvider.fontSize),
                    ),

                    //删除按钮
                    trailing: GestureDetector(
                      onTap: () {
                        showSimpleDialog(context,timelineNew);
                      },
                      child: Icon(
                        Icons.more_vert,
                        size: 24,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            //朋友圈图片
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.memory(
                    base64Decode(timelineNew.imagePath),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserIconImage(
    BuildContext context,
    User userNew,
  ) {
    final notifier = Provider.of<TimeLinePageNotifier>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return MaterialButton(
      onPressed: () {
        notifier.updateUserImage(userNew);
        //点击图片后更新头像
        //notifier.updateUserImage(userNew);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        //データベース中の画像使う時だけ書くSQliteだけ
        child: Image.memory(
          base64Decode(userProvider.getFirstUser().userImage),
          gaplessPlayback: true,
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
      ),
    );
  }

  void showSimpleDialog(BuildContext context,timelineNew) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final timelineProvider = Provider.of<TimelineProvider>(context);
        final databaseProvider =
            Provider.of<DataBaseProvider>(context, listen: false);
        return CommonSimpleDialog(
          title: "Are you sure to delete this timeline?",
          onPressed: () {
            
            timelineProvider.deleteTimeline(timelineNew.id);
                databaseProvider.deleteTimeLine(timelineNew.id);
                Navigator.of(context).pop(false);
          },
        );
        
      },
    );
  }
}
