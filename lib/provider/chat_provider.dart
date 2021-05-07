import 'package:flutter/material.dart';

import 'package:wechat_like_memo/model/chat.dart';

class ChatProvider with ChangeNotifier {
  ChatProvider({
    this.chatList,
  });

  List<Chat> chatList;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  //クラス中の関数
  void addchat(
    Chat chat,
    int userId,
    int isLeft,
    String createdAt,
    int isImage,
    String imagePath,
     //受け取りたいやつ
  ) {
    chatList.add(chat);
    notifyListeners();
  }

  void updatechat(
    //2, うけとる
    int id,
    Chat newChat,
    int isLeft,
    String createdAt,
    int isImage,
    String imagePath,
  ) {
    final chatIndex = chatList.indexWhere(
      (chat) => chat.id == id,
    );
    chatList[chatIndex] = newChat;
    notifyListeners();
  }

  void deletechat(int id) {
    final chatIndex = chatList.indexWhere((chat) => chat.id == id);
    chatList.removeAt(chatIndex);
    notifyListeners();
  }

  
}
