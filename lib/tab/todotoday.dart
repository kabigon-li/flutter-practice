import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';

class TodoTaday extends StatefulWidget {
  TodoTaday({Key key}) : super(key: key);

  @override
  _TodoTadayState createState() => _TodoTadayState();
}

class _TodoTadayState extends State<TodoTaday> {
  bool checked = false;

  // Dart
  void onPressed(bool value) {
    checked = value;
    setState(() {});
  }

  String text = '';

  void chatbox(String input) {
    text = input;
    setState(() {});
  }

  var flag = false;

  @override
  Widget build(BuildContext context) {
    final season = Provider.of<SeasonsMode>(context);
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[200],
        leading: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        title: Center(
          child: Text(
            'To do',
            style: TextStyle(fontFamily: 'Cursive', fontSize: 30),
          ),
        ),
      ),
      body: Stack(children: [
        // Stackの中のやつ使える
        Positioned.fill(
          child: Container(
             decoration: BoxDecoration(
              image: season.isImageSelected
                  ? DecorationImage(
                      image: AssetImage(
                        imageList[season.selectedImageNumber],
                      ),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: AssetImage(
                        'image/chatpageimage.jpg',
                      ),
                      fit: BoxFit.cover,
                    )
            ),
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
                          todoProvider
                              .todoList[index], //调用todo这个方法时，这获取画面中更新的每行Todo
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[200],
        child: Icon(Icons.add_box_outlined),
        onPressed: () {
          return openModalBottomSheet();
        },
      ),
    );
  }

  Widget todo(
    // Todo(id: 0, content: 'k', isChecked: 0)
    Todo todoNew, //这接收新一个Todo
  ) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //显示在屏幕上的每一条todo，由打沟框，todo内容，和删除按钮组成
        Card(
          color: Colors.grey[200],
          child: CheckboxListTile(
            //打勾框
            activeColor: Colors.blue,
            value: todoNew.isChecked == 0 ? false : true,
            onChanged: (v) {
              //クタスの実体化、Todoをtodoに代入
              setState(() {
                // checkboxl押された時,下実行する
                Todo newTodo = Todo(
                  //Todoの実体化（クラスのインスタンス）
                  //受け取るやつ次第
                  id: todoNew.id, //受け取るのTodoのid
                  content: todoNew.content, //受け取るTodoの内容
                  isChecked: todoNew.isChecked == 0 ? 1 : 0, //もし０、１になる、もし１、０になる
                );
                todoProvider.updateTodo(
                  //1, 渡す 0
                  todoNew.id,
                  newTodo,
                );
              });
            },

            //todo内容部分
            title: SizedBox(
              //height: 20,
              //クリック編集
              child: GestureDetector(
                onTap: () {
                  updateBottomSheet(
                    //例えば、カビゴン書いたら、ここに渡す
                    todoNew.id, //获取第一行的id，0
                    todoNew.isChecked, //获取第一行的是否勾选
                  );
                },
                child: Text(
                  todoNew.content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    decoration: todoNew.isChecked == 0
                        ? null
                        : TextDecoration.lineThrough,
                  ),
                ),
              ),
            ),

            //删除按钮
            secondary: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                //todoNew.id
                deleteTodoSheet(todoNew.id);
              },
            ),
          ),
        ),

        //分割线
        const Divider(
          height: 2,
          thickness: 1,
          color: Colors.grey,
          indent: 10,
          // endIndent: 20,
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

//updateBottom接收
  void updateBottomSheet(int index, int f) {
    //index受け取る
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
                    SizedBox(
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
                            isChecked: f,
                          );
                          todoProvider.updateTodo(
                            //1, 渡す 0
                            index,
                            newTodo,
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
