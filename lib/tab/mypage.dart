import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/colorTheme.dart';
import 'package:wechat_like_memo/model/fontSize.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';

import 'package:wechat_like_memo/provider/appTheme_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/font_size_provider.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _active = false;
  int num;
  String fontSizeText;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<AppTheme>(context);

    final colorThemeProvider = Provider.of<ColorThemeProvider>(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorList[colorThemeProvider.themeNumber ?? 4],
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    '設定',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'iconfont',
                      color: fontColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body:
            // dark mode
            SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 600,
                width: 500,
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: 'テーマ設定',
                      titleTextStyle:
                          TextStyle(fontSize: 20, color: Colors.brown),
                      tiles: [
                        SettingsTile.switchTile(
                          title: 'ダークモード',
                          titleTextStyle: TextStyle(fontSize: 18),
                          leading: Icon(Icons.nights_stay),
                          switchValue: theme.isDark,
                          onToggle: (newTheme) {
                            theme.changeMode();
                          },
                          switchActiveColor: buttonColor,
                        ),
                        SettingsTile(
                          title: 'テーマ色',
                          titleTextStyle: TextStyle(fontSize: 18),
                          leading: Icon(Icons.color_lens),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onPressed: (BuildContext context) {
                            showChangeColorDialog(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 300,
              //   width: 500,
              //   child: SettingsList(
              //     sections: [
              //       SettingsSection(
              //         title: 'Personal Settings',
              //         titleTextStyle:
              //             TextStyle(fontSize: 20, color: Colors.brown),
              //         tiles: [
              //           SettingsTile(
              //             title: 'ChatPage background ',
              //             titleTextStyle: TextStyle(fontSize: 18),
              //             //subtitle: 'English',
              //             leading: Icon(Icons.photo),
              //             trailing: Icon(Icons.arrow_forward_ios),
              //             onPressed: (BuildContext context) {},
              //           ),
              //           SettingsTile(
              //             title: 'fontSize',
              //             titleTextStyle: TextStyle(fontSize: 18),
              //             subtitle: fontSizeText,
              //             leading: Icon(Icons.format_size),
              //             trailing: Icon(Icons.arrow_forward_ios),
              //             onPressed: (BuildContext context) {
              //               showFontSizeDialog(context);
              //             },
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),

        // // spring背景設定
        // springMode(),

        // //summer 背景設定
        // summerMode(),

        // autumnMode(),

        // winterMode(),
      ),
    );
  }

  void showFontSizeDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        final fontSizeProvider = Provider.of<FontSizeProvider>(context);
        final databaseProvider =
            Provider.of<DataBaseProvider>(context, listen: false);
        FontSize fontSize = FontSize();

        return SimpleDialog(
          // title: Text("Font size"),
          children: <Widget>[
            // コンテンツ領域
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        FontSize newFontSize = fontSize.copyWith(
                          fontSize: 24,
                        );
                        fontSizeText = 'Large';
                        fontSizeProvider.updateFontSize(24.0);
                        databaseProvider.updateDataFontSize(newFontSize);

                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Text(
                        "Large",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FontSize newFontSize = fontSize.copyWith(
                          fontSize: 20,
                        );
                        fontSizeText = 'Medium';
                        fontSizeProvider.updateFontSize(20.0);
                        databaseProvider.updateDataFontSize(newFontSize);
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Text(
                        "Medium",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FontSize newFontSize = fontSize.copyWith(
                          fontSize: 16,
                        );
                        fontSizeText = 'Small';
                        fontSizeProvider.updateFontSize(16.0);
                        databaseProvider.updateDataFontSize(newFontSize);
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Text(
                        "Small",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showChangeColorDialog(BuildContext context) async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        final databaseProvider =
            Provider.of<DataBaseProvider>(context, listen: false);
        final colorThemeProvider = Provider.of<ColorThemeProvider>(context);
        return SimpleDialog(
          // title: Text("Font size"),
          children: <Widget>[
            // コンテンツ領域
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: SizedBox(
                height: 150,
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        colorThemeProvider.updateSelectedImageNumber(0);
                        Navigator.of(context).pop();

                        final currentTheme = ColorTheme(
                          id: 0,
                          themeNumber: 0, // 色に応じて、0, 1, 2などの番号
                        );
                        databaseProvider.updateDataColorTheme(currentTheme);
                      },
                      child: Text(
                        "Metallic Pink",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(241, 177, 186, 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        colorThemeProvider.updateSelectedImageNumber(1);
                        Navigator.of(context).pop();
                        final currentTheme = ColorTheme(
                          id: 0,
                          themeNumber: 1, // 色に応じて、0, 1, 2などの番号
                        );
                        databaseProvider.updateDataColorTheme(currentTheme);
                      },
                      child: Text(
                        "Cool Grey",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(148, 137, 176, 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        colorThemeProvider.updateSelectedImageNumber(2);
                        Navigator.of(context).pop();
                        final currentTheme = ColorTheme(
                          id: 0,
                          themeNumber: 2, // 色に応じて、0, 1, 2などの番号
                        );
                        databaseProvider.updateDataColorTheme(currentTheme);
                      },
                      child: Text(
                        "Fresh Air",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(168, 222, 250, 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        colorThemeProvider.updateSelectedImageNumber(3);
                        Navigator.of(context).pop();
                        final currentTheme = ColorTheme(
                          id: 0,
                          themeNumber: 3, // 色に応じて、0, 1, 2などの番号
                        );
                        databaseProvider.updateDataColorTheme(currentTheme);
                      },
                      child: Text(
                        "Olivine",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(161, 183, 122, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
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
          value: season.selectedImageNumber == 2 ? true : false,
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

  winterMode() {
    final season = Provider.of<SeasonsMode>(context);
    return Stack(children: [
      Container(
        decoration: season.selectedImageNumber == 3
            ? BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "image/winter.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: SwitchListTile(
          value: season.selectedImageNumber == 3 ? true : false,
          onChanged: (_) {
            if (season.selectedImageNumber == 3) {
              season.updateSelectedImageNumber(100);
              season.updateIsImageSelected(false);
            } else {
              season.updateSelectedImageNumber(3);
              season.updateIsImageSelected(true);
            }
          },
          activeColor: Colors.blue,
          activeTrackColor: Colors.blue,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey,
          secondary: ClipOval(
            child: Image.asset(
              'image/wintericon.png',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text('Winter mode'),
          subtitle: Text('snow'),
        ),
      ),
    ]);
  }

  color(MaterialColor brown) {}
}
