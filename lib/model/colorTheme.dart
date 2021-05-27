import 'package:flutter/material.dart';

class ColorTheme {
  ColorTheme({
    this.id,
    this.colorTheme,
  });

  final int id;
  final Color colorTheme;

  ColorTheme copyWith({
    int id,
    Color colorTheme,
  }) {
    return ColorTheme(
      id: id ?? this.id,
      colorTheme: colorTheme ?? this.colorTheme,
    );
  }

  Map<String, dynamic> toMap() {
    return {
       'id': id,
      'colorTheme': ColorTheme,
    };
  }
}
