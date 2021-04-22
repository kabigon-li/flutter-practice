import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wechat_like_memo/pages/calender.dart';
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
 static GlobalKey<NavigatorState> calenderNavigatorKey =
      GlobalKey<NavigatorState>();
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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.today_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.today_outlined,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.people,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings_applications,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.settings_applications,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.calendar_today,
              color: Colors.blue,
            ),
          ),
        ],
        onTap: _onTapHandler,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.white,
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
                return TimeLine();
              },
            );
          case 3:
            return CupertinoTabView(
              builder: (context) {
                return MyPage();
              },
            );
          case 4:
            return CupertinoTabView(
              builder: (context) {
                return Calender();
              },
            );
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
