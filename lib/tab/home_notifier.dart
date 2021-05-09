import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/Utility/utility.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
import 'package:wechat_like_memo/tab/home.dart';

class HomeNotifier extends ChangeNotifier {
  HomeNotifier({
    this.context,
  });
  final BuildContext context;
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
  TextEditingController controller;
  File _image;

  final picker = ImagePicker();
  void chatbox(String input) {
    text = input;
    notifyListeners();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // 写真取得する（获取照片）
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void onPressedAddButton() {
    final userProvider = Provider.of<UserProvider>(context);
    var fileName;
    String imgString;

    fileName = basename(_image.path);

    // 画像を文字に変換する
    // provider、データベースに画像保存する時、base64Stringに変換する
    imgString = Utility.base64String(_image.readAsBytesSync());

    // TODO: User追加 - addUser
    User usernow = User(
      id: userProvider.userList.length,
      userImage: imgString,
      userName: controller.text,
    );

    userProvider.addUser(usernow);

    userProvider.updateIslogined(true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }
}
