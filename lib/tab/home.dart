import 'dart:io';

import 'package:flutter/material.dart';
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
  const Home({
    this.image, //class受け取る
    this.idtext,
  });

  // 受け取りたい値
  final File image;
  final String idtext;

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
    final notifier = Provider.of<HomeNotifier>(context, listen: false);
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
                    child: notifier.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              notifier.image,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          )
                        //image为空时显示空
                        : Row(
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
                  accountName: notifier.idtext != null
                      ? Text(
                          notifier.idtext,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            //fontFamily: 'Cursive',
                          ),
                        )
                      : Text(
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
          GestureDetector(
            onTap: () {
              openAddUserSheet(context);
            },
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
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                //用户头像，保存ID名称和头像图片之后显示
                Row(
                  children: [
                    //当image不为空时，显示头像
                    notifier.image != null
                        ? _buildHomeIconImage(context)
                        //image为空时显示空
                        : _buildHomeIconBlank(context),
                    // 用户ID，保存ID名称和头像图片之后显示
                    if (notifier.idtext != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildHomeName(context),
                      ),

                    //点击之后进入聊天页面
                    _buildClickChatBox(context),
                  ],
                ),
                SizedBox(height: 15),
                const Divider(
                  height: 2,
                  thickness: 2,
                  color: themeColor,
                  indent: 10,
                  endIndent: 10,
                ),

                //每点加一次加号，增加一个user
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                  itemCount: userProvider.userList.length,
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

  Widget user(BuildContext context, User userNew) {
    final userProvider = Provider.of<UserProvider>(context);
    return Column(
      children: [],
    );
  }

// 関数はWidget　buildの外で書く
  Widget _buildHomeIconImage(BuildContext context) {
    final notifier = Provider.of<HomeNotifier>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        notifier.image,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildHomeIconBlank(BuildContext context) {
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

  Widget _buildHomeName(BuildContext context) {
    final notifier = Provider.of<HomeNotifier>(context, listen: false);
    return Text(
      notifier.idtext,
      style: TextStyle(
        fontSize: 25,
        color: Colors.grey[700],
        fontWeight: FontWeight.bold,
        //fontFamily: 'Cursive',
      ),
    );
  }

  Widget _buildClickChatBox(BuildContext content) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          content,
          MaterialPageRoute(
            builder: (context) => ChatPage(),
          ),
        );
      },
      child: Column(
        //竖列两个组件对其
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UserName',
            style: TextStyle(
              fontSize: 22,
              color: fontColor,
            ),
          ),
          Text(
            'Click here to chat!',
            style: TextStyle(
              fontSize: 22,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  void openAddUserSheet(BuildContext context) {
    final notifier = Provider.of<HomeNotifier>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                //width: size.width,
                child: Row(
                  //Row Column中・二個か二個以上widgetの間隙間決める
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 250,
                      child: ColoredBox(
                        color: Colors.white,
                        child: TextField(
                          maxLines: 20,
                          onChanged: (String t) {
                            notifier.chatbox(t);
                          },
                          decoration: InputDecoration(
                            hintText: 'Please white a new User !',
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: SizedBox(
                        height: 50,
                        width: 70,
                        child: ElevatedButton(
                          child: Text(
                            'Add',
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
