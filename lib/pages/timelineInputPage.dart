import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TimelineInputPage extends StatefulWidget {

  
  TimelineInputPage({
    this.image, //class受け取る
  });

  final File image;

  @override
  _TimelineInputPageState createState() => _TimelineInputPageState();
}

class _TimelineInputPageState extends State<TimelineInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'chatpage',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Cursive',
            fontSize: 30,
          ),
        ),
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              Icons.double_arrow_rounded,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            
            Image.file(
              widget.image,
              height: 300,
              width: 400,
            ),
          ],
        ),
      ),
    );
  }
}
