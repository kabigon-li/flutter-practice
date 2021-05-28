import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_like_memo/model/colorTheme.dart';

class ColorThemeProvider extends ChangeNotifier {
  // 初期化
  ColorThemeProvider({
    this.colorList,
  });

  List<ColorTheme> colorList;

  // 選択されている画像の番号
  int selectedColorNumber;

  void updateSelectedImageNumber(int number) {
    selectedColorNumber = number;
    notifyListeners();
  }
}
