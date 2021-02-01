import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_like_memo/tab/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File _image;
  Image imageIcon;
  final picker = ImagePicker();

  TextEditingController controller;

  @override
  void initState() {
    super.initState();

    // 空文字で初期化 - TextFormで使う
    controller = TextEditingController();
    controller.text = '';
  }

  //头像拦
  iconImageField() {
    return InkWell(
      onTap: () async {
        // 点按”アルバムから選択”按钮后，获取相册照片
        await getImage();

        //只有在选择了照片时，向下一个页面移动
        if (_image != null) {
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.file(
                _image,
              ),
            ),
          );
        }
      },
      child: Row(
        children: [
          ClipOval(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: _image == null
                  ? Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.black38,
                      size: 50,
                    )
                  : ClipOval(
                      child: Image.file(
                        _image,
                        height: 50,
                        width: 50,
                      ),
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

                // ID name
                TextFormField(
                  // controllerは入力されたやつ
                  controller: controller,
                  obscureText: false,
                  //style: style,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "ID name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: 35.0),

                // 登陆按钮
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    // minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(
                            image: _image,
                            idtext: controller.text,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      // style: style.copyWith(
                      //     color: Colors.white, fontWeight: FontWeight.bold
                    ),
                    //     ),
                  ),
                ),
                SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
