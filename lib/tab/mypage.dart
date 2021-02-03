import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/provider/appTheme_provider.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _active = false;

  void _changeSwitch(bool e) => setState(
        () => _active = e,
      );
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[200],
          leading: MaterialButton(
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
          title: Center(
            child: Text(
              'Setting',
              style: TextStyle(fontFamily: 'Cursive', fontSize: 30),
            ),
          ),
        ),
        body: Container(
          child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  new SwitchListTile(
                    value: theme.isDark,
                    onChanged: (_) {
                      theme.changeMode();
                    },
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey,
                    secondary: new Icon(
                      Icons.thumb_up,
                      color: _active ? Colors.orange[700] : Colors.grey[500],
                      size: 50.0,
                    ),
                    title: Text('タイトル'),
                    subtitle: Text('サブタイトル'),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
