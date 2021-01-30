import 'package:flutter/material.dart';

class Timeline {
  Timeline({
    this.id,
    this.content,
    this.picture,
    this.color,
    
  });

  final int id;
  final String content;
  final Image picture;
  final Color color;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'picture': picture,
      'color' : color,
     
    };
  }
}