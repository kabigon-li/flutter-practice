import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool like = false;

  String text = '';

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text(
            'chatpage',
            style: TextStyle(color: Colors.black),
          ),
          toolbarHeight: 30,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.double_arrow_rounded,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        body: Container(
          child: Stack(
            children: [
              ListView.builder(
                //physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return chat();
                },
              ),
              
              textfild(),

              ],
          ),
        ));
  }

  Widget textfild(){
    final size = MediaQuery.of(context).size;
  return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 60,
                    width: size.width,
                    child: ColoredBox(
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: size.width * .7,
                            child: ColoredBox(
                              color: Colors.white,
                              child: TextField(
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
                          SizedBox(width: 10),
                          SizedBox(
                            height: 35,
                            width: size.width * .2,
                            child: RaisedButton(
                              color: Colors.green[300],
                              child: Text(
                                '送信',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                return openChatBox();
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

  Widget chat() {
    final todoProvider = Provider.of<TodoProvider>(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: 3, //繰り返す10回
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 10); //間の隙間
          },
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget openChatBox() {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Container();
  }
}
