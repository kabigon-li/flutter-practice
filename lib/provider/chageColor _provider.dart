import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeThemeColor extends ChangeNotifier {
  // 初期化
  ChangeThemeColor({
    this.isColorSelected = false,
    this.selectedColorNumber = 0,
  });

  // 画像選択されているかどうか判定
  bool isColorSelected;

  // 選択されている画像の番号
  int selectedColorNumber;

  void updateIsImageSelected(bool value) {
    isColorSelected = value;
    notifyListeners();
  }

  void updateSelectedImageNumber(int number) {
    selectedColorNumber = number;
    notifyListeners();
  }
}
