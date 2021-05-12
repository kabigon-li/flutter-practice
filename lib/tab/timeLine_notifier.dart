import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:wechat_like_memo/Utility/utility.dart';

class TimeLineNotifier extends ChangeNotifier {
  TimeLineNotifier({
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
}
