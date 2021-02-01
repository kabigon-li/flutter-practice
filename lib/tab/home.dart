import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/tab/timeLine.dart';
import 'package:wechat_like_memo/pages/chatPage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],

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
            size: 35,
          ),
        ),

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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(children: [
            //用户头像，保存ID名称和头像图片之后显示
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'image/kabigon.jpeg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),

              // 用户ID，保存ID名称和头像图片之后显示
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ID name',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      //fontFamily: 'Cursive',
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20,
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
              child: Text(
                " Hello ! Click here to chat !",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  //fontFamily: 'Cursive',
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
