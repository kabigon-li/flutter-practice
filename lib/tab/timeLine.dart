import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  TimeLine({Key key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        leadingWidth: MediaQuery.of(context).size.width,
        centerTitle: true,
        backgroundColor: Colors.green[300],
        leading: Image.asset(
          'image/kabi.jpeg',
          width: MediaQuery.of(context).size.width,
          //height: 30,
          //fit:BoxFit.fitWidth,

        ),
        ),
        body: Container(),
      );
  }
}