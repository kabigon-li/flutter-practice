import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  FontSizeProvider({
    this.fontSize = 22.0,
  });

  double fontSize;

  void updateFontSize(
    double newFontSize,
  ) {
    //updateFontSize(24.0)中fontSize被赋予24;
    fontSize = newFontSize;
  }
}
