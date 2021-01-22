import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TimelineInputPage extends StatefulWidget {
  TimelineInputPage({Key key}) : super(key: key);

  @override
  _TimelineInputPageState createState() => _TimelineInputPageState();
}

class _TimelineInputPageState extends State<TimelineInputPage> {
  File _image;
  final picker = ImagePicker(); 

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final ImagePicker _picker = ImagePicker();
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
          TextField(),
        ],
      )),
    );
  }
}
