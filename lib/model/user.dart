import 'package:flutter/material.dart';

class User {
  User({
    this.id,
    this.isLogined,
    this.userImage,
    this.userName,
  });

  final int id;
  final int isLogined;
  final String userImage;
  final String userName;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isLogined': isLogined,
      'userImage': userImage,
      'userName': userName,
    };
  }
}
