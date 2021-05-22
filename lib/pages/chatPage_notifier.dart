

import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import 'package:wechat_like_memo/model/chat.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';


class ChatPageNotifier extends ChangeNotifier {
  ChatPageNotifier({
    this.context,
    //userNew を渡してもいい、あとで使えるかも
    this.userNew,
    
  });
  final BuildContext context;
  final User userNew;
 
  bool like = false;
  String text = '';
  

  final now = DateTime.now();
  

  final formKey = GlobalKey<FormState>();

  void chatbox(String input) {
    text = input;
    notifyListeners();
  }
                     //函数的参数
  void addChatContent({int isLeft}) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);

    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    Chat chatNow = Chat(
      id: chatProvider.chatList.length,
      content: text,
      userId: userNew.id,
      createdAt: now.toIso8601String(),
      isLeft: isLeft,
      isImage: 0,
      imagePath: '',
    );

    chatProvider.addchat(
      chatNow,
    );

    databaseProvider.insertChat(
      chat: chatNow,
      
    );

    //chatbox('');

    // 入力内容リセット
    formKey.currentState.reset();

    // フォームにフォーカスがある際に、解除する(输入栏收回)
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void updateChatContent(Chat chatNew) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    Chat newChat = chatNew.copyWith(
      content: text,
    );
    chatProvider.updatechat(
      //1, 渡す 0
      newChat.id,
      newChat,
    );
    databaseProvider.updateChat(newChat);
    Navigator.of(context).pop();
  }

  

 

  
}
