import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeasonsMode extends ChangeNotifier {
  // 初期化
  SeasonsMode({
    this.isSpring = false,
  });

  bool isSpring;

  void changeMode() {
    isSpring = !isSpring;
    notifyListeners();
  }
}
