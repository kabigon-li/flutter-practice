import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[200],
          leading: Icon(
            Icons.account_circle,
            color: Colors.black,
          ),
          title: Center(
            child: Text(
              'Setting',
              style: TextStyle(fontFamily: 'Cursive', fontSize: 30),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("Dark mode"),
                trailing: Icon(Icons.more_vert),
                
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text("font size"),
                trailing: Icon(Icons.more_vert),
                
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
