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
              fontFamily: 'Roboto',
              letterSpacing: 1.0,
            ),
          ),
        ),

        //tabBar
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Row(children: [
            ClipOval(
              child: Image.asset(
                'image/kabigon.jpeg',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(),
                  ),
                );
                //Navigator.of(context).pushNamed('/chatpage');
              },
              child: Text(
                " Hello ! Click here to chat !",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
