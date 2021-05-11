import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/pages/chatPage.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
import 'package:wechat_like_memo/tab/home_notifier.dart';
import 'package:wechat_like_memo/tab/todotoday.dart';

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
    final notifier = Provider.of<HomeNotifier>(context);
    final userProvider = Provider.of<UserProvider>(context);
    // print(season.selectedImageNumber);
    return Scaffold(
      // 左ドロアー
      drawer: Drawer(
        //key: drawerKey,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                // header
                UserAccountsDrawerHeader(
                  //icon图标，当每上传照片时为登陆图标，上传照片后显示图片
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.account_circle,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //ID name
                  accountName: Text(
                    '＠Memolady',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      //fontFamily: 'Cursive',
                    ),
                  ),

                  accountEmail: Text('@WetchatMemo.kabigon'),

                  //背景
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                  ),
                ),

                // make an account
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Text('Make an account'),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),

                // move to chatpage
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Text('Move to chatpage'),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Icon(
                      Icons.chat,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),

                //move to todopage
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoTaday(
                            isNavigateFromDrawer: true,
                          ),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Text('Move to todopage'),
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoTaday(),
                        ),
                      );
                      //Navigator.of(context).pushNamed('/chatpage');
                    },
                    child: Icon(
                      Icons.today_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: themeColor,

        title: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                'Wochat',
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
                Icons.add_circle,
                color: Colors.grey,
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
        ],
      ),
    );
  }

  Widget user(
    BuildContext context,

    //Userのひとり分、UserimageとUserName使いたい時、User.imageで呼ぶ
    User userNew,
  ) {
    return Row(
      children: [
        //User由大致三部分组成，1。头像 2.昵称 3.显示最新聊天

        //1. 头像：默认显示默认头像icon，登陆后显示头像图片
        userNew.userImage != null
            ? _buildUserIconImage(
                context,
                userNew,
              )
            //image为空时显示默认头像icon
            : _buildUserIconBlank(context),

        //2. 昵称
        _buildUserName(context, userNew),

        //3. 显示最新聊天和时间
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

  Widget _buildUserIconBlank(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xff01A0C7),
            child: Icon(
              Icons.account_circle,
              size: 60,
              color: Colors.yellow,
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(),
          ),
        );
      },
      child: Column(
        //竖列两个组件对其
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              userNew.userName,
              style: TextStyle(
                fontSize: 23,
                color: fontColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'Click here to chat!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
