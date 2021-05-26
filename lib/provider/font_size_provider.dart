import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  FontSizeProvider({
    this.fontSize = 15.0,
    this.isFontSizeSelected = false,
  });

  double fontSize;
  bool isFontSizeSelected;

   void updateIsImageSelected(bool value) {
    isFontSizeSelected = value;
    notifyListeners();
  }

  void updateFontSize(
    double newFontSize,
  ) {

    //updateFontSize(24.0)中fontSize被赋予24;
    fontSize = newFontSize;
  }
}
