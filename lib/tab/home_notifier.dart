import 'dart:io';

import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  HomeNotifier({
    this.context,
    this.image, 
     this.idtext,

  });
  final BuildContext context;
  final File image;
  final String idtext;

   TabController _tabController;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = new TabController(
  //     length: 5,
  //     vsync: this,
  //   );
  // }

  String text = '';
  void chatbox(String input) {
    text = input;
    notifyListeners();
  }
}
