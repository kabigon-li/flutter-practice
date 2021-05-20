import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/Utility/utility.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';

class TimeLinePageNotifier extends ChangeNotifier {
  TimeLinePageNotifier({
    this.id,
    this.context,
    this.imagePath,
    this.color,
  });
  final int id;
  final BuildContext context;
  final String imagePath;
  final Color color;

  String text = '';
  String imgString;
  File image;

  void chatbox(String input) {
    text = input;
    notifyListeners();
  }

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // 写真取得する（获取照片）
    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    var fileName;

    fileName = basename(image.path);

    // 画像を文字に変換する
    // provider、データベースに画像保存する時、base64Stringに変換する
    imgString = Utility.base64String(image.readAsBytesSync());

    notifyListeners();
  }

  void updateUserImage(
    // 更新したいやつここで受け取る
    User userNew,
  ) async {
    // TodoProviderの実体化
    //imgString = Utility.base64String(_image.readAsBytesSync());
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    await getImage();
    // 更新する時にcontextだけ更新したい時、CopyWithを使う
    User newUser = userNew.copyWith(
      userImage: imgString,
    );

    userProvider.updateUser(
      newUser,
    );

    databaseProvider.updateUser(
      newUser,
    );

    // 一つ前の画面に戻る
    // Navigator.of(context).pop();
  }
}
