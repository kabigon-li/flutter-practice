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
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  //physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                  itemCount: todoProvider.todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return todo(
                      // 1. Todo(id: 0, content: 'k', isChecked: 0)
                      // 2. Todo(id: 1, content: 'kabigon', isChecked: 0)
                      todoProvider.todoList[index],
                    );
                  },
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

  Widget todo(
    // Todo(id: 0, content: 'k', isChecked: 0)
    Todo todoNew,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
            //クリック編集
            child: GestureDetector(
              onTap: () {
                updateBottomSheet(
                  todoNew.id,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  todoNew.content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration:
                        flag == true ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: () {
              deleteTodoSheet(todoNew.id);
            },
            child: Icon(Icons.delete),
          ),
        ),
      ],
    );
  }

  void deleteTodoSheet(int index) {
    // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.deleteTodo(
      //1, 渡す 0
      index,
    );
  }

  void updateBottomSheet(int index) {
    // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
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
                          initialValue: text,
                          onChanged: (String t) {
                            chatbox(t);
                          },
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
                          child: Text('編集'),
                          color: Colors.blueGrey,
                          onPressed: () {
                            //クタスの実体化、Todoをtodoに代入
                            Todo newTodo = Todo(
                              id: index,
                              content: text,
                              isChecked: 0,
                            );
                            todoProvider.updateTodo(
                              //1, 渡す 0
                              index,
                              newTodo,
                            );
                            Navigator.of(context).pop();
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
                          onChanged: (String t) {
                            chatbox(t);
                          },
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
                            Todo todoNow = Todo(
                              id: todoProvider.todoList.length,
                              content: text,
                              isChecked: 0,
                            );
                            todoProvider.addTodo(todoNow);
                            Navigator.of(context).pop();
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
