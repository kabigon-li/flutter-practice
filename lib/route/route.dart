import 'package:flutter/material.dart';
import 'package:wechat_like_memo/pages/chatPage.dart';
import 'package:wechat_like_memo/pages/loginPage.dart';
import 'package:wechat_like_memo/tab/todotoday.dart';
import 'package:wechat_like_memo/tab/home.dart';
import 'package:wechat_like_memo/tab/mypage.dart';
import 'package:wechat_like_memo/tab/timeLine.dart';

final routes = {
  '/tab': (context, {arguments}) => Tab(),
  '/homepage': (context) => Home(),
  '/mypage': (context) => MyPage(),
  '/todotoday': (context) => TodoTaday(),
  '/chatpage': (context) => ChatPage(),
  '/timeline': (context) => TimeLine(),
  '/loginpage' : (context) => LoginPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
