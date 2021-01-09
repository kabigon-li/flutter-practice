import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';

class TodoTaday extends StatefulWidget {
  TodoTaday({Key key}) : super(key: key);

  @override
  _TodoTadayState createState() => _TodoTadayState();
}

class _TodoTadayState extends State<TodoTaday> {
  bool checked = false;
  int checked2 = 0;

  // Dart
  void onPressed(bool value) {
    checked = value;
    setState(() {});
  }

  String text = '';

  void onPressed1(bool value1) {
    checked = value1;
    setState(() {});
  }

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  var flag = false;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[300],
        leading: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        title: Center(
          child: Text(
            'To do',
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                    itemCount: todoProvider.,
                    itemBuilder: (BuildContext context, int index) {
                      return todo1();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.input),
        onPressed: () {
          return openModalBottomSheet();
        },
      ),
    );
  }

  Widget todo() {
    return Row(
      children: [
        //icon表示
        text == ''
            ? Container()
            : GestureDetector(
                onTap: () {
                  if (checked == true) {
                    onPressed(false);
                  } else {
                    onPressed(true);
                  }
                },
                child: checked == true
                    ? SizedBox(
                        height: 60,
                        child: Icon(
                          Icons.check_box_rounded,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )
                    : SizedBox(
                        height: 60,
                        child: Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
              ),

        //to do
        Expanded(
          child: GestureDetector(
            onTap: openModalBottomSheet,
            child: ColoredBox(
              color: Colors.white,
              child: SizedBox(
                  //height: 60,
                  child: checked == true
                      ? Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            text,
                            style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            text,
                            style: new TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        )),
            ),
          ),
        )
      ],
    );
  }

  Widget todo1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            CheckboxListTile(
              value: this.flag,
              onChanged: (v) {
                setState(() {
                  this.flag = v;
                });
              },
              title: SizedBox(
                //height: 60,
                child: flag == true
                    ? GestureDetector(
                        onTap: openModalBottomSheet,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: openModalBottomSheet,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        )
      ],
    );
  }

  void openModalBottomSheet() {
    // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final size = MediaQuery.of(context).size;
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
                        child: TextField(
                          maxLines: 20,
                          // onChanged: (String t) {
                          //   chatbox(t);
                          // },
                          decoration: InputDecoration(
                            hintText: 'to do',
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: SizedBox(
                        height: 30,
                        width: 60,
                        child: RaisedButton(
                          child: Text('送信'),
                          color: Colors.blueGrey,
                          onPressed: () {
                            //クタスの実体化、Todoをtodoに代入
                            Todo todo = Todo(
                              id: 0,
                              content: text,
                              isChecked: 0,
                            );
                            todoProvider.addTodo(todo);
                          },
                        ),
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
}
