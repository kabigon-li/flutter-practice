import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';

// Dartのコード管理、ロジックの管理
// extends - 継承
class TodoTodayNotifier extends ChangeNotifier {
  // クラスの初期化
  TodoTodayNotifier({
    this.context,
    this.isNavigateFromDrawer,
  });

  // 初期化する内容
  final BuildContext context;
  final bool isNavigateFromDrawer;

  bool checked = false;
  String text = '';
  var flag = false;
  

  // Dart

  void onPressed(bool value) {
    checked = value;
    notifyListeners();
  }

  void chatbox(String input) {
    text = input;
    notifyListeners();
  }

  void updateTodoContent(
    // 更新したいやつここで受け取る
    Todo todoNew,
  ) {
    // TodoProviderの実体化
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    // 更新する時にcontextだけ更新したい時、CopyWithを使う
    Todo newTodo = todoNew.copyWith(
      content: text,
    );

    todoProvider.updateTodo(
      //1, 渡す 0
      newTodo,
    );

    // 一つ前の画面に戻る
    Navigator.of(context).pop();
  }

  void updateCheckBox(
    //todoNew を受け取って、これから使えるようにった
    Todo todoNew,
  ) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);

    //クタスの実体化、Todoをtodoに代入

    //当只有ischecked改变的时候，todo model里写copywith
    Todo newTodo = todoNew.copyWith(
      isChecked: todoNew.isChecked == 0 ? 1 : 0, //もし０、１になる、もし１、０になる
    );

    todoProvider.updateTodo(
      //1, 渡す 0
      newTodo,
    );

    databaseProvider.updateTodo(
      newTodo,
    );
    notifyListeners();
  }

  void addTodo() {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    //クタスの実体化、Todoをtodoに代入
    Todo todoNow = Todo(
      id: todoProvider.todoList.length,
      content: text,
      isChecked: 0,
    );
    todoProvider.addTodo(todoNow);

    //databaseに追加
    databaseProvider.insertTodo(
      // datebase and todo渡す
      todo: todoNow,
    );

    Navigator.of(context).pop();
  }

  void deleteTodo(int index) {
    // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    //　databaseの実体化
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);
    todoProvider.deleteTodo(
      //1, 渡す 0
      index,
    );
    databaseProvider.deleteTodo(index);
  }
}
