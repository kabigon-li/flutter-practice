import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //头像拦
  iconImageField() {
    return InkWell(
      onTap: () async {
        // 点按”アルバムから選択”按钮后，获取相册照片
        await getImage();

        //只有在选择了照片时，向下一个页面移动
        // if (_image != null) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => TimelineInputPage(
        //         image: _image, //次のクラスに渡す
        //         timelineNew: timelineNow,
        //       ),
        //     ),
        //   );
        // }
      },
      child: Row(
        children: [
          ClipOval(
                      child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Icon(
                Icons.add_a_photo_outlined,
                color: Colors.black38,
                size: 50,
              ),
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.grey[300]),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '⬅️click to choose an icon',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //ID栏
  final idField = TextField(
    obscureText: false,
    //style: style,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "ID name",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  );

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // 写真取得する（获取照片）
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    setState(() {});
  }

  //登陆按钮
  final loginButon = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Color(0xff01A0C7),
    child: MaterialButton(
      // minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {},
      child: Text(
        "Login",
        textAlign: TextAlign.center,
        // style: style.copyWith(
        //     color: Colors.white, fontWeight: FontWeight.bold
      ),
      //     ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('log in'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(
                //   height: 155.0,
                //   child: Image.asset(
                //     "assets/logo.png",
                //     fit: BoxFit.contain,
                //   ),
                // ),
                SizedBox(height: 25.0),

                iconImageField(),

                SizedBox(height: 45.0),

                idField,

                SizedBox(
                  height: 35.0,
                ),

                loginButon,

                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
