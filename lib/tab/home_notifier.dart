import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/Utility/utility.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
import 'package:wechat_like_memo/tab/home.dart';

class HomeNotifier extends ChangeNotifier {
  HomeNotifier({
    this.context,
  });
  final BuildContext context;
  TabController _tabController;
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey();

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = new TabController(
  //     length: 5,
  //     vsync: this,
  //   );
  // }

  String text = '';
  String imgString;
  TextEditingController controller;
  File _image;

  final picker = ImagePicker();
  void chatbox(String input) {
    text = input;
    notifyListeners();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    // 写真取得する（获取照片）
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }

    var fileName;

    fileName = basename(_image.path);

    // 画像を文字に変換する
    // provider、データベースに画像保存する時、base64Stringに変換する
    imgString = Utility.base64String(_image.readAsBytesSync());

    notifyListeners();
  }

  void onPressedAddButton() {
    final userProvider = Provider.of<UserProvider>(context);
    var fileName;
    String imgString;

    fileName = basename(_image.path);

    // 画像を文字に変換する
    // provider、データベースに画像保存する時、base64Stringに変換する
    imgString = Utility.base64String(_image.readAsBytesSync());

    // TODO: User追加 - addUser
    User usernow = User(
      id: userProvider.userList.length,
      userImage: imgString,
      userName: controller.text,
    );

    userProvider.addUser(usernow);

    userProvider.updateIslogined(true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  void updateUserImage(
    // 更新したいやつここで受け取る
    User userNew,
  ) async {
    // TodoProviderの実体化
    //imgString = Utility.base64String(_image.readAsBytesSync());
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await getImage();
    // 更新する時にcontextだけ更新したい時、CopyWithを使う
    User newUser = userNew.copyWith(
      userImage: imgString,
    );

    userProvider.updateUser(
      newUser,
    );

    // 一つ前の画面に戻る
    // Navigator.of(context).pop();
  }

  void updateUserName(
    User userNew,
  ) async {
    // TodoProviderの実体化
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                //width: size.width,
                child: Row(
                  //Row Column中・二個か二個以上widgetの間隙間決める
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: ColoredBox(
                        color: Colors.white,
                        child: TextFormField(
                          maxLines: 8,
                          initialValue: userNew.userName,
                          onChanged: (String t) {
                            chatbox(t);
                          },
                          decoration: InputDecoration(
                            hintText: userNew.userName,
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 70,
                      child: ElevatedButton(
                        child: Text(
                          '編集',
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(175, 209, 171, 1),
                        ),
                        onPressed: () {
                          User newUser = userNew.copyWith(
                            userName: text,
                          );

                          userProvider.updateUser(
                            //1, 渡す 0
                            newUser,
                          );

                          // 一つ前の画面に戻る
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    // 更新する時にcontextだけ更新したい時、CopyWithを使う
  }

  void addUserName() async {
    // TodoProviderの実体化
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                //width: size.width,
                child: Row(
                  //Row Column中・二個か二個以上widgetの間隙間決める
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: ColoredBox(
                        color: Colors.white,
                        child: TextFormField(
                          maxLines: 8,
                          //initialValue: userNew.userName,
                          onChanged: (String t) {
                            chatbox(t);
                          },
                          decoration: InputDecoration(
                            //hintText: userNew.userName,
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 70,
                      child: ElevatedButton(
                        child: Text(
                          '編集',
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(175, 209, 171, 1),
                        ),
                        onPressed: () {
                          final userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          final databaseProvider =
                              Provider.of<DataBaseProvider>(context,
                                  listen: false);
                          //クタスの実体化、Todoをtodoに代入
                          User userNow = User(
                            id: userProvider.userList.length,
                            userImage: imgString,
                            userName: controller.text,
                          );
                          userProvider.addUser(userNow);

                          //databaseに追加
                          databaseProvider.insertUser(
                            // datebase and todo渡す
                            user: userNow,
                          );

                          // 一つ前の画面に戻る
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

   
  }

  void deleteUser(int index,userNew){
     // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    //　databaseの実体化
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    userProvider.deleteUser(
      //1, 渡す 0
      index,
    );
    databaseProvider.deleteUser(index);
  }
}
