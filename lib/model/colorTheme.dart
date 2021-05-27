import 'package:flutter/material.dart';

class ColorTheme {
  ColorTheme({
    this.colorTheme,
  });

  final Color colorTheme;
 
 
  ColorTheme copyWith({
   Color colorTheme,
  }) {
    return ColorTheme(
      colorTheme: colorTheme ?? this.colorTheme,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'colorTheme': ColorTheme,
     
    };
  }
}
