import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/provider/appTheme_provider.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _active = false;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);
    final season = Provider.of<SeasonsMode>(context);
    return Container(
      child: Scaffold(
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
              'Setting',
              style: TextStyle(fontFamily: 'Cursive', fontSize: 30),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              // dark mode
              SwitchListTile(
                // 右：valueはture,左：valueはfalse
                value: theme.isDark,
                onChanged: (_) {
                  theme.changeMode();
                },
                activeColor: Colors.orange,
                activeTrackColor: Colors.orange,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                secondary: new Icon(
                  Icons.nightlight_round,
                  color: _active ? Colors.orange[700] : Colors.grey[500],
                  size: 30.0,
                ),
                title: Text('dark mode'),
              ),

              // 背景設定
              Stack(children: [
                Container(
                  decoration: season.isSpring
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "image/sakura.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                  child: SwitchListTile(
                    value: season.isSpring,
                    onChanged: (_) {
                      season.changeMode();
                    },
                    activeColor: Colors.orange,
                    activeTrackColor: Colors.orange,
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey,
                    secondary: ClipOval(
                      child: Image.asset(
                        'image/springmode.jpg',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text('Spring mode'),
                    subtitle: Text('sakura'),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
