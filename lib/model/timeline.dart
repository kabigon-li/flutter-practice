import 'package:flutter/material.dart';

class Timeline {
  Timeline({
    this.id,
    this.context,
    this.imagePath,
    this.color,
  });

  final int id;
  final String context;
  final String imagePath;
  final Color color;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'context': context,
      'imagePath': imagePath,
      'color': color,
    };
  }
}
