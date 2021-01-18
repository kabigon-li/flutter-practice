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
        toolbarHeight: 100,
        leadingWidth: MediaQuery.of(context).size.width,
        centerTitle: true,
        backgroundColor: Colors.green[200],
        // leading: Image.asset(
        //   'image/kabi.jpeg',
        //   width: MediaQuery.of(context).size.width,
        //   //height: 30,
        //   //fit:BoxFit.fitWidth,

        // ),
      ),
      body: Scrollbar(
          child:
              //添加图片图标
              Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Column(
            children: [
              Icon(
                Icons.add_a_photo,
                size: 35,
                color: Colors.blueGrey,
              ),

               //timeline
              ColoredBox(
        color:Colors.grey,
        ),
            ],
          ),
        ),
      ),

     
      
      ),
    );
  }
}
