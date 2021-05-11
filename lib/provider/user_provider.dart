import 'package:flutter/foundation.dart';
import 'package:wechat_like_memo/model/user.dart';

class UserProvider with ChangeNotifier {
  UserProvider({
    this.isLogined = false,
    this.userList,
  });

  List<User> userList;
  bool isLogined;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  void updateIslogined(bool value) {
    isLogined = value;
    notifyListeners();
  }

  User getFirstUser() {
    return userList.first;
  }

  //クラス中の関数
  void addUser(
    User user, //受け取りたいやつ
  ) {
    userList.add(user);
    notifyListeners();
  }

  void updateUser(
    //2, うけとる
   
    User newuser,
  ) {
    final userIndex = userList.indexWhere(
      (user) => user.id == newuser.id,
    );
    userList[userIndex] = newuser;
    notifyListeners();
  }

  void deleteuser(int id) {
    final userIndex = userList.indexWhere((user) => user.id == id);
    userList.removeAt(userIndex);
    notifyListeners();
  }
}
