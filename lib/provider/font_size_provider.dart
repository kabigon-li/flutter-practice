import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FontSizeProvider extends ChangeNotifier {
  FontSizeProvider({
    this.fontSize = 15.0,
  });

  double fontSize;

  void updateFontSize(
    double newFontSize,
  ) {
    fontSize = newFontSize;
  }
}
