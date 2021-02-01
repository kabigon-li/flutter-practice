import 'package:flutter/material.dart';

class Timeline {
  Timeline({
    this.id,
    this.content,
    this.imagePath,
    this.color,
  });

  final int id;
  final String content;
  final String imagePath;
  final Color color;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'imagePath': imagePath,
      'color': color,
    };
  }
}
