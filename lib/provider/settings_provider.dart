import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeasonsMode extends ChangeNotifier {
  // 初期化
  SeasonsMode({
    this.isImageSelected = false,
    this.selectedImageNumber = 0,
  });

  // 画像選択されているかどうか判定
  bool isImageSelected;

  // 選択されている画像の番号
  int selectedImageNumber;

  void updateIsImageSelected(bool value) {
    isImageSelected = !isImageSelected;
    notifyListeners();
  }

  void updateSelectedImageNumber(int number) {
    selectedImageNumber = number;
    notifyListeners();
  }
}
