import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';

import 'package:wechat_like_memo/model/chat.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/pages/chatPage_notifier.dart';

import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';

import 'package:intl/intl.dart';

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
                context,
                currentUserChatList[index],
              );
            },
          ),
          textfild(context),
        ],
      ),
    );
  }

  Widget textfild(BuildContext context) {
    final notifier = Provider.of<ChatPageNotifier>(context);
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
                  key: notifier.formKey,
                  child: SizedBox(
                    height: 90,
                    width: size.width * .7,
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
                      notifier.addChatContent();
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
    BuildContext context,
    Chat chatNew,
  ) {
    // final chatProvider = Provider.of<ChatProvider>(context);
    // final size = MediaQuery.of(context).size;
    final notifier = Provider.of<ChatPageNotifier>(context);

    String outputFormat = DateFormat('MM-dd-H:mm').format(notifier.now);
    double m = chatNew.content.length.toDouble();
    return Scrollbar(
      //对话框文字
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              //删除对话框图标
              onLongPress: () {
                showSimpleDialog(context, chatNew);
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    width: 180,
                    
                    child: GestureDetector(
                      onTap: () {
                        updateChatBottomSheet(
                          context,
                          chatNew.id,
                          chatNew.content,
                          chatNew,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 8),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                outputFormat,
                style: TextStyle(fontSize: 14),
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
}
