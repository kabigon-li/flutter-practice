import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/Utility/utility.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey),
              ),
          child: _image == null
              ? Icon(
                  Icons.add_photo_alternate,
                  color: Color.fromRGBO(124, 166, 221, 1),
                  size: 70,
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _image,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
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
    final userProvider = Provider.of<UserProvider>(context);
    final colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left:30.0,top:20),
          child: OverflowBox(
            maxWidth: 100,
            maxHeight: 100,
            child: GestureDetector(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: colorList[colorThemeProvider.themeNumber ?? 4],
       
      ),
      body: SingleChildScrollView(
              child: Container(
          //color: Color.fromRGBO(232, 232, 229, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 40.0),

                //头像拦
                iconImageField(),
                SizedBox(height: 40.0),

                // ID name
                TextFormField(
                    // controllerは入力されたやつ
                    controller: controller,
                    //obscureText: false,
                    //style: style,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                      hintText: "User name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                SizedBox(height: 25.0),

                // 登陆按钮
                Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: colorList[colorThemeProvider.themeNumber ?? 4],
                  child: SizedBox(
                    width: 500,
                    height: 60,
                    child: MaterialButton(
                      // minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        final databaseProvider =
                            Provider.of<DataBaseProvider>(context,
                                listen: false);
                        var fileName;
                        String imgString;

                        fileName = basename(_image.path);

                        // 画像を文字に変換する
                        // provider、データベースに画像保存する時、base64Stringに変換する
                        imgString =
                            Utility.base64String(_image.readAsBytesSync());

                        // TODO: User追加 - addUser
                        User userNow = User(
                          id: userProvider.userList.length,
                          userImage: imgString,
                          userName: controller.text,
                        );

                        userProvider.addUser(userNow);

                        userProvider.updateIslogined(true);

                        databaseProvider.insertUser(
                          // datebase and todo渡す
                          user: userNow,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'iconfont',
                          color: Color.fromRGBO(74, 61, 105, 1),
                        ),
                        textAlign: TextAlign.center,
                        // style: style.copyWith(
                        //     color: Colors.white, fontWeight: FontWeight.bold
                      ),
                      //     ),
                    ),
                  ),
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
