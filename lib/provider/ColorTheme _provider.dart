import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorThemeProvider extends ChangeNotifier {
  // 初期化
  ColorThemeProvider({
    this.colorTheme,
    this.selectedColorNumber,
  });

  Color colorTheme;

  // 選択されている画像の番号
  int selectedColorNumber;

  void updateSelectedImageNumber(int number) {
    selectedColorNumber = number;
    notifyListeners();
  }
}
