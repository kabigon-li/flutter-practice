import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/pages/chatPage.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/tab/todotoday.dart';

class Home extends StatefulWidget {
  Home({
    this.image, //class受け取る
    this.idtext,
  });
  final File image;
  final String idtext;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
      length: 5,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final season = Provider.of<SeasonsMode>(context);
    print(season.selectedImageNumber);
    return Scaffold(
      // 左ドロアー
      drawer: Drawer(
        
        key: drawerKey,
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
                    child: widget.image != null
                        ? ClipOval(
                            child: Image.file(
                              widget.image,
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
                  accountName: widget.idtext != null
                      ? Text(
                          widget.idtext,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            //fontFamily: 'Cursive',
                          ),
                        )
                      : Text(''),

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
        backgroundColor: Colors.green[200],

        title: Center(
          child: Text(
            'chat home',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cursive',
              letterSpacing: 1.0,
            ),
          ),
        ),

        //tabBar
      ),
      body: Stack(
        children: [
          Container(
            //背景設定
            decoration: BoxDecoration(
              image: season.isImageSelected
                  ? DecorationImage(
                      image: AssetImage(
                        imageList[season.selectedImageNumber],
                      ),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: AssetImage(
                        'image/home.png',
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              //用户头像，保存ID名称和头像图片之后显示
              Row(
                children: [
                  //当image不为空时，显示图片
                  widget.image != null
                      ? ClipOval(
                          child: Image.file(
                            widget.image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        )
                      //image为空时显示空
                      : Container(),

                  // 用户ID，保存ID名称和头像图片之后显示
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.idtext != null
                        ? Text(
                            widget.idtext,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              //fontFamily: 'Cursive',
                            ),
                          )
                        : Row(
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
                                  borderRadius: BorderRadius.circular(30.0),
                                  //color: Color(0xff01A0C7),
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 60,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),

              SizedBox(
                height: 40,
              ),

              //点击之后进入聊天页面
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(),
                    ),
                  );
                },
                child: SizedBox(
                  height: 150,
                  width: 300,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.grey[200],
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Thank you for downloading!\nClick here to chat!',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            //fontFamily: 'Cursive',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
