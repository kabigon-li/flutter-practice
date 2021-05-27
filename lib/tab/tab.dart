import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/pages/calender.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';
import 'package:wechat_like_memo/route/route.dart';
import 'package:wechat_like_memo/tab/todotoday.dart';
import 'package:wechat_like_memo/tab/home.dart';
import 'package:wechat_like_memo/tab/mypage.dart';
import 'package:wechat_like_memo/tab/timeLine.dart';

class NavigationHolder {
  static GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> chatRoomNavigatorKey =
      GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> settingsNavigatorKey =
      GlobalKey<NavigatorState>();
//  static GlobalKey<NavigatorState> calenderNavigatorKey =
//       GlobalKey<NavigatorState>();
}

class TabScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  final String pageIndex;

  TabScreen({
    this.pageIndex,
  });

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _defaultIndex = 0;
  int _selectedIndex = 0;

  void _onTapHandler(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = _defaultIndex;
  }

  @override
  Widget build(BuildContext context) {
     final colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.chat_bubble,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.chat_bubble,
              color: buttonColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
            Icons.check_box,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.check_box,
              color: buttonColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.camera,
              color: buttonColor,
            ),
          ),
         
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings_applications,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.settings_applications,
              color: buttonColor,
            ),
          ),
          
        ],
        onTap: _onTapHandler,
        currentIndex: _selectedIndex,
        backgroundColor: colorList[colorThemeProvider.selectedColorNumber ?? 4],
        iconSize: 30,
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              navigatorKey: NavigationHolder.homeNavigatorKey,
              builder: (context) {
                return Home();
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return TodoTaday();
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return TimeLinePage(userNew);
              },
            );
          
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return MyPage();
              },
            );

            // case 4:
            // return 
            // CupertinoTabView(
            //   builder: (context) {
            //     return Calender();
            //   },
              
            // );
          default:
            {
              return CupertinoTabView(
                builder: (context) {
                  return Home();
                },
              );
            }
        }
      },
    );
  }
}
