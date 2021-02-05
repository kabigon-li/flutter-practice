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
  int num;

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
                activeColor: Colors.blue,
                activeTrackColor: Colors.blue,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                secondary: new Icon(
                  Icons.nightlight_round,
                  color: _active ? Colors.orange[700] : Colors.grey[500],
                  size: 30.0,
                ),
                title: Text('dark mode'),
              ),

              // spring背景設定
              springMode(),

              //summer 背景設定
              summerMode(),

              autumnMode(),
            ],
          ),
        ),
      ),
    );
  }

  springMode() {
    final season = Provider.of<SeasonsMode>(context);

    return Stack(children: [
      Container(
        decoration: season.selectedImageNumber == 0
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "image/spring.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: SwitchListTile(
          value: season.selectedImageNumber == 0 ? true : false,
          // 押された後時更新する
          onChanged: (_) {
            if (season.selectedImageNumber == 0) {
              season.updateSelectedImageNumber(100);
              season.updateIsImageSelected(false);
            } else {
              season.updateSelectedImageNumber(0);
              season.updateIsImageSelected(true);
            }
          },
          activeColor: Colors.blue,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey,
          secondary: ClipOval(
            child: Image.asset(
              'image/springicon.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Spring mode'),
          subtitle: Text('sakura'),
        ),
      ),
    ]);
  }

  summerMode() {
    final season = Provider.of<SeasonsMode>(context);
    return Stack(children: [
      Container(
        decoration: season.selectedImageNumber == 1
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "image/summer.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: SwitchListTile(
          value: season.selectedImageNumber == 1 ? true : false,
          onChanged: (_) {
            if (season.selectedImageNumber == 1) {
              season.updateSelectedImageNumber(100);
              season.updateIsImageSelected(false);
            } else {
              season.updateSelectedImageNumber(1);
              season.updateIsImageSelected(true);
            }
          },
          activeColor: Colors.blue,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey,
          secondary: ClipOval(
            child: Image.asset(
              'image/summericon.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Summer mode'),
          subtitle: Text('sea'),
        ),
      ),
    ]);
  }

  autumnMode() {
    final season = Provider.of<SeasonsMode>(context);
    return Stack(children: [
      Container(
        decoration: season.selectedImageNumber == 2
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "image/autumn.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: SwitchListTile(
          value: season.selectedImageNumber == 1 ? true : false,
          onChanged: (_) {
            if (season.selectedImageNumber == 2) {
              season.updateSelectedImageNumber(100);
              season.updateIsImageSelected(false);
            } else {
              season.updateSelectedImageNumber(2);
              season.updateIsImageSelected(true);
            }
          },
          activeColor: Colors.blue,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey,
          secondary: ClipOval(
            child: Image.asset(
              'image/autumnicon.jpg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Autumn mode'),
          subtitle: Text('紅葉'),
        ),
      ),
    ]);
  }
}

