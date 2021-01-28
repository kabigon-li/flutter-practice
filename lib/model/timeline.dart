import 'package:flutter/material.dart';

class Timeline {
  Timeline({
    this.id,
    this.content,
    this.picture,
    
  });

  final int id;
  final String content;
  final Image picture;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'picture': picture,
     
    };
  }
}