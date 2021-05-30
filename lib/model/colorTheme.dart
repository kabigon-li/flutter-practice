import 'package:flutter/material.dart';


class ColorTheme {
  ColorTheme({
    this.id,
    this.colorTheme,
    //用数字的形式保存数据库，因为数据库不能保存颜色，图片，视频等
    this.themeNumber,
  });

  final int id;
  final Color colorTheme;
  final int themeNumber;

  ColorTheme copyWith({
    int id,
    Color colorTheme,
    int themeNumber,
  }) {
    return ColorTheme(
      id: id ?? this.id,
      colorTheme: colorTheme ?? this.colorTheme,
      themeNumber: themeNumber ?? this.themeNumber,
    );
  }

 

  Map<String, dynamic> toMap() {
    return {
       'id': id,
      'colorTheme': colorTheme,
      'themeNumber': themeNumber,
      
    };
  }
}
