import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';

import 'package:wechat_like_memo/model/chat.dart';
import 'package:wechat_like_memo/model/user.dart';

import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    this.userNew,
    
  });
  final User userNew;
  
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool like = false;
  String text = '';

  final now = DateTime.now();

  final formKey = GlobalKey<FormState>();

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final season = Provider.of<SeasonsMode>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    //寻找chatlist 中的userID和 UsernewID 相同的id
    final currentUserChatList = chatProvider.chatList
        .where((chat) => chat.userId == widget.userNew.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                widget.userNew.userName,
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'iconfont',
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: 50,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(209, 246, 255, 1),
              // ? DecorationImage(
              //     image: AssetImage(
              //       imageList[season.selectedImageNumber],
              //     ),
              //     fit: BoxFit.cover,
              //   )
            ),
          ),
          ListView.builder(
            //physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true, // 高さ関連のエラーが出たら、使う
            itemCount: currentUserChatList.length,
            itemBuilder: (BuildContext context, int index) {
              return chat(
                currentUserChatList[index],
              );
            },
          ),
          textfild(widget.userNew),
        ],
      ),
    );
  }

  Widget textfild(userNew) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final databaseProvider =
      Provider.of<DataBaseProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 100,
          width: size.width,
          child: ColoredBox(
            color: Colors.grey[200],
            child: Row(
              children: [
                //textfild
                Form(
                  key: formKey,
                  child: SizedBox(
                    height: 90,
                    width: size.width * .7,
                    child: ColoredBox(
                      color: Colors.white,
                      child: TextFormField(
                        maxLines: 20,
                        onChanged: (String text) {
                          chatbox(text);
                        },
                        decoration: InputDecoration(
                          hintText: 'Tell me your thinking',
                          contentPadding: const EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                //送信button
                SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: size.width * .2,
                  child: ElevatedButton(
                    child: Text(
                      '送信',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[300],
                    ),

                    //チャット追加
                    onPressed: () {
                      final chatNow = Chat(
                        id: chatProvider.chatList.length,
                        content: text,
                        userId: userNew.id,
                        createdAt: now.toIso8601String(),
                      );
                      chatProvider.addchat(
                        chatNow,
                      );
                      //databaseProvider.insertChat();

                      chatbox('');

                      // 入力内容リセット
                      formKey.currentState.reset();

                      // フォームにフォーカスがある際に、解除する(输入栏收回)
                      FocusScope.of(context).requestFocus(FocusNode());

                      //收起输入框
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return ChatPage();
                      //     },
                      //   ),
                      // );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //绿色对话框和删除键
  Widget chat(
    Chat chatNew,
  ) {
    // final chatProvider = Provider.of<ChatProvider>(context);
    // final size = MediaQuery.of(context).size;
    String outputFormat = DateFormat('MM-dd-H:mm').format(now);
    return Scrollbar(
      //对话框文字
      child: Row(
        children: [
          GestureDetector(
            //删除对话框图标
            onLongPress: () {
              showSimpleDialog(chatNew);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  width: 180,
                  //height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: GestureDetector(
                      onTap: () {
                        updateChat(
                          chatNew.id,
                          chatNew.content,
                        );
                      },
                      child: Text(
                        chatNew.content,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(outputFormat)),
          ),
        ],
      ),
    );
  }

  void updateChat(
    int index,
    String input,
  ) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    showModalBottomSheet(
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
                      height: 200,
                      width: 200,
                      child: ColoredBox(
                        color: Colors.white,
                        child: TextFormField(
                          maxLines: 20,
                          initialValue: input,
                          onChanged: (String t) {
                            chatbox(t);
                          },
                          decoration: InputDecoration(
                            //hintText: 'chat',
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 60,
                      child: ElevatedButton(
                        child: Text('編集'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                        ),
                        onPressed: () {
                          //クタスの実体化、Todoをtodoに代入
                          Chat newChat = Chat(
                            id: index,
                            content: text,
                          );
                          chatProvider.updatechat(
                            //1, 渡す 0
                            index,
                            newChat,
                          );
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

  void deleteChat(int index) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    chatProvider.deletechat(index);
  }

  void showSimpleDialog(userNew) async {
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Select account'),
          ),
          children: <Widget>[
            SimpleDialogOption(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade200,
                  child: Icon(Icons.delete_outline),
                ),
                title: Text(
                  'delete',
                  style: TextStyle(
                    color: fontColor,
                    fontSize: 22,
                  ),
                ),
              ),
              onPressed: () {
                deleteChat(userNew.id);
                Navigator.pop(
                  context,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
