import 'package:flutter/material.dart';
import 'package:wechat_like_memo/model/chatRoom.dart';




class ChatRoomProvider with ChangeNotifier {
  ChatRoomProvider({
    this.chatRoomList,
  });

  List<ChatRoom> chatRoomList;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  //クラス中の関数
  void addchat(
    ChatRoom chat,
  ) {
    chatRoomList.add(chat);
    notifyListeners();
  }

  void updatechat(
    //2, うけとる
    int id,
    ChatRoom newChatRoom,
  ) {
    final chatIndex = chatRoomList.indexWhere(
      (chat) => chat.id == id,
    );
    chatRoomList[chatIndex] = newChatRoom;
    notifyListeners();
  }

  void deletechat(int id) {
    final chatIndex = chatRoomList.indexWhere((chat) => chat.id == id);
    chatRoomList.removeAt(chatIndex);
    notifyListeners();
  }
}
