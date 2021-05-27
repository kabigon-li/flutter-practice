import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat_like_memo/model/fontSize.dart'; 

class FontSizeProvider extends ChangeNotifier {
  FontSizeProvider({
    this.fontSize,
  });

  double fontSize;

  void updateFontSize(
    double newFontSize,
  ) {
    //updateFontSize(24.0)中fontSize被赋予24;
    fontSize = newFontSize;
  }
}
