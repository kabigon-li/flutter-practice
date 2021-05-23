import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';

import 'package:wechat_like_memo/model/chat.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/pages/chatPage_notifier.dart';

import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';

import 'package:intl/intl.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage(
    this.userNew,
  );

  final User userNew;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Notifier作成
      create: (_) => ChatPageNotifier(
        //受け取る
        context: context,
        userNew: userNew,
      ),
      child: _ChatPage(),
    );
  }
}

class _ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final season = Provider.of<SeasonsMode>(context);
    final notifier = Provider.of<ChatPageNotifier>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    // print(notifier.userNew.id);
    //寻找chatlist 中的userID和 UsernewID 相同的id,每一个聊天页面中显示不同聊天内容
    final currentUserChatList = chatProvider.chatList
        .where((chat) => chat.userId == notifier.userNew.id)
        .toList();

    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Text(
                notifier.userNew.userName,
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
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
            SingleChildScrollView(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, // 高さ関連のエラーが出たら、使う

                //重复已有聊天个数的次数
                itemCount: currentUserChatList.length,
                itemBuilder: (BuildContext context, int index) {
                  //重复已有聊天个数的次数，例如有五个聊天重复五次
                  return chat(
                    context,
                    currentUserChatList[index],
                  );
                },
              ),
            ),
            SizedBox(child: textfild(context)),
          ],
        ),
      ),
    );
  }

  Widget textfild(BuildContext context) {
    final notifier = Provider.of<ChatPageNotifier>(context);
    final size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80,
        width: size.width,
        child: ColoredBox(
          color: themeColor,
          child: Row(
            children: [
              //输入框
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Form(
                  key: notifier.formKey,
                  child: SizedBox(
                    height: 70,
                    width: 230,
                    child: ColoredBox(
                      color: Colors.white,
                      child: TextFormField(
                        maxLines: 20,
                        onChanged: (String text) {
                          notifier.chatbox(text);
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
              ),

              //送信button

              Row(
                children: [
                  //发送左边消息
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      height: 40,
                      width: size.width * .13,
                      child: ElevatedButton(
                        child: Text(
                          '◀︎',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[300],
                        ),

                        //チャット追加
                        onPressed: () {
                          notifier.addChatContent(isLeft: 0);
                        },
                      ),
                    ),
                  ),

                  //发送右边消息
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      height: 40,
                      width: size.width * .13,
                      child: ElevatedButton(
                        child: Text(
                          '▶︎',
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[300],
                        ),

                        //チャット追加
                        onPressed: () {
                          notifier.addChatContent(isLeft: 1);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //绿色对话框
  Widget chat(
    BuildContext context,
    Chat chatNew,
  ) {
    return chatNew.isLeft == 0
        ? leftChat(
            context,
            chatNew,
            0,
          )
        : rightChat(
            context,
            chatNew,
            1,
          );
  }

  Widget leftChat(
    BuildContext context,
    Chat chatNew,
    isLeft,
  ) {
    DateTime chattime;
    String outputFormat;
    try {
      chattime = DateTime.parse(chatNew.createdAt);
      outputFormat = DateFormat('MM-dd-H:mm').format(chattime);
    } catch (e) {
      debugPrint(e.toString());
    }
    //userid寻找与userid相同的chatid，返回此时的userid
    final currentUser = Provider.of<UserProvider>(context)
        .userList
        .firstWhere((user) => user.id == chatNew.userId);

    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              //删除对话框图标
              onLongPress: () {
                showSimpleDialog(context, chatNew);
              },
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: buildUserIconImage(
                      context: context,
                      currentUser: currentUser,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.green[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            updateChatBottomSheet(
                              context,
                              chatNew.id,
                              chatNew.content,
                              chatNew,
                            );
                          },
                          child: SizedBox(
                            // width: 280,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                child: Text(
                                  chatNew.content,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8.0, bottom: 8),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                outputFormat ?? '',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget rightChat(
    BuildContext context,
    Chat chatNew,
    int isLeft,
  ) {
    DateTime chattime;
    String outputFormat;
    //chattime = DateTime.parse(chatNew.createdAt);
    try {
      chattime = DateTime.parse(chatNew.createdAt);
      outputFormat = DateFormat('MM-dd-H:mm').format(chattime);
    } catch (e) {
      debugPrint(e.toString());
    }
    //outputFormat = DateFormat('MM-dd-H:mm').format(chattime);
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            //删除对话框图标
            onLongPress: () {
              showSimpleDialog(context, chatNew);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          updateChatBottomSheet(
                            context,
                            chatNew.id,
                            chatNew.content,
                            chatNew,
                          );
                        },
                        child: SizedBox(
                          // width: 280,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Expanded(
                              child: Text(
                                chatNew.content,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                //头像
                buildFirstUserIconImage(context: context),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8.0, bottom: 8),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                outputFormat ?? '',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateChatBottomSheet(
    BuildContext context,
    int index,
    String input,
    Chat chatNew,
  ) {
    final notifier = Provider.of<ChatPageNotifier>(context, listen: false);

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
                            notifier.chatbox(t);
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
                          notifier.updateChatContent(chatNew);
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

  void deleteChat(BuildContext context, int index) {
    final chatProvider = Provider.of<ChatProvider>(context, listen: false);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);

    chatProvider.deletechat(index);

    databaseProvider.deleteChat(index);
  }

  void showSimpleDialog(BuildContext context, chatNew) async {
    final notifier = Provider.of<ChatPageNotifier>(context, listen: false);
    String result = "";
    result = await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Are you sure to delete this chat ?'),
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
                deleteChat(context, chatNew.id);
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

  Widget buildUserIconImage({
    BuildContext context,
    User currentUser,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      //データベース中の画像使う時だけ書くSQliteだけ
      child: Image.memory(
        base64Decode(currentUser.userImage),
        gaplessPlayback: true,
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
    );
  }

  Widget buildFirstUserIconImage({
    BuildContext context,
  }) {
    final userProvider = Provider.of<UserProvider>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      //データベース中の画像使う時だけ書くSQliteだけ
      child: Image.memory(
        base64Decode(userProvider.getFirstUser().userImage),
        gaplessPlayback: true,
        fit: BoxFit.cover,
        height: 50,
        width: 50,
      ),
    );
  }
}
