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

  void updateCheckBox(
    //todoNew を受け取って、これから使えるようにった
    Todo todoNew,
  ) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    final databaseProvider =
        Provider.of<DataBaseProvider>(context, listen: false);

    //クタスの実体化、Todoをtodoに代入

    Todo newTodo = todoNew.copyWith(
      isChecked: todoNew.isChecked == 0 ? 1 : 0, //もし０、１になる、もし１、０になる
    );

    todoProvider.updateTodo(
      //1, 渡す 0
      todoNew.id,
      newTodo,
    );

    databaseProvider.updateTodo(
      newTodo,
    );
    notifyListeners();
  }

  void updateTodo() {}
}
