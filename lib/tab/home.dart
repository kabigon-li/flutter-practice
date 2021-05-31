import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import 'package:wechat_like_memo/constant/constants.dart';

import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/pages/chatPage.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';
import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/font_size_provider.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
import 'package:wechat_like_memo/tab/home_notifier.dart';

class Home extends StatelessWidget {
  const Home();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Notifier作成
      create: (_) => HomeNotifier(
        context: context,
      ),
      child: _Home(),
    );
  }
}

class _Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final season = Provider.of<SeasonsMode>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    // print(season.selectedImageNumber);
    return Scaffold(
      // 左ドロアー
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorList[colorThemeProvider.themeNumber ?? 4],
        title: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                'Mechat',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'iconfont',
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          //点击添加按钮进入login页面，添加用户
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            // 添加按钮
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.person_add_rounded,
                color: buttonColor,
                size: 30,
              ),
            ),
          ),
        ],

        //tabBar
      ),
      body: Stack(
        children: [
          if (season.isImageSelected)
            Container(
              //背景設定
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    imageList[season.selectedImageNumber],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //用户头像，保存ID名称和头像图片之后显示

                  //每点加一次加号，增加一个user
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                    itemCount: userProvider.userList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return // 分割线
                          const Divider(
                        height: 2,
                        thickness: 2,
                        color: themeColor,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return user(
                        context,
                        // 1. Todo(id: 0, content: 'k', isChecked: 0)
                        // 2. Todo(id: 1, content: 'kabigon', isChecked: 0)
                        userProvider
                            .userList[index], //调用user这个方法时，这获取画面中更新的每行Todo
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget user(
    BuildContext context,

    //Userのひとり分、UserimageとUserName使いたい時、User.imageで呼ぶ
    User userNew,
  ) {
    final notifier = Provider.of<HomeNotifier>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //User由大致三部分组成，1。头像 2.昵称 3.显示最新聊天

        //1. 用户头像：默认显示默认头像icon，登陆后显示头像图片
        userNew.userImage != null
            ? _buildUserIconImage(
                context,
                userNew,
              )
            //image为空时显示默认头像icon
            : _buildUserIconBlank(
                context,
                userNew,
              ),

        //2. 用户名称
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userNew,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 250,
            //height: 60,
            child: GestureDetector(
              // 跳转到聊天页面

              //长按显示dialog，删除用户
              onLongPress: () {
                notifier.showSimpleDialog(userNew);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userNew.userName != null && userNew.userName.isNotEmpty
                      ? _buildUserName(context, userNew)
                      : _buildUserNameBlank(context, userNew),

                  //3. 当用户名为空白时新建用户
                  _buildUserLastChat(
                    context,
                    userNew,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

// 関数はWidget　buildの外で書く
  Widget _buildUserIconImage(
    BuildContext context,
    User userNew,
  ) {
    final notifier = Provider.of<HomeNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: MaterialButton(
        onPressed: () {
          notifier.updateUserImage(userNew);
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

  Widget _buildUserIconBlank(
    BuildContext context,
    User userNew,
  ) {
    //默认用户
    final notifier = Provider.of<HomeNotifier>(context);
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            notifier.updateUserImage(userNew);
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[300],
            child: Icon(
              Icons.account_box,
              size: 50,
              color: Color.fromRGBO(130, 176, 104, 05),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserName(
    BuildContext context,
    User userNew,
  ) {
    final notifier = Provider.of<HomeNotifier>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            notifier.updateUserName(userNew);
          },
          child: Column(
            //竖列两个组件对其
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //点击用户名，更改新的用户名
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        userNew.userName,
                        style: TextStyle(
                          // fontSize: fontSizeProvider.isFontSizeSelected == true
                          fontSize: fontSizeProvider.fontSize,
                          //:20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        //点击用户名称右边进入聊天页面
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(userNew),
              ),
            );
          },
          child: Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 150,
              height: 40,
              child: Text(
                '',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserNameBlank(
    BuildContext context,
    User userNew,
  ) {
    final notifier = Provider.of<HomeNotifier>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return GestureDetector(
      onTap: () {
        notifier.updateUserName(userNew);
      },
      child: Column(
        //竖列两个组件对其
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No userName',
            style: TextStyle(
              fontSize: fontSizeProvider.fontSize,
              color: fontColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserLastChat(
    BuildContext context,
    User userNew,
  ) {
    final chatProvider = Provider.of<ChatProvider>(context);

    final lastChat = chatProvider?.chatList?.lastWhere(
      (chat) => chat.userId == userNew.id,
      orElse: () => null,
    );
    final now = DateTime.now();
    final createdAt = now.toIso8601String();

    DateTime chattime = DateTime.parse(createdAt);
    String outputFormat = DateFormat('MM-dd-H:mm').format(chattime);

    //final notifier = Provider.of<HomeNotifier>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(userNew),
          ),
        );
      },
      child: SizedBox(
        width: 300,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 170,
              child: Text(
                lastChat != null ? lastChat.content.toString() : '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              lastChat != null ? outputFormat : '',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
