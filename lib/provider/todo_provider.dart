import 'package:flutter/material.dart';
import 'package:wechat_like_memo/model/todo.dart';

class TodoProvider with ChangeNotifier {
  TodoProvider({
    this.todoList,
  });

  List<Todo> todoList;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  //クラス中の関数
  void addTodo(
    Todo todo, //受け取りたいやつ
  ) {
    todoList.add(todo);
    notifyListeners();
  }

  void updateTodo(
    //2, うけとる
    int id,
    Todo newTodo,
  ) {
    final todoIndex = todoList.indexWhere(
      (todo) => todo.id == id,
    );
    todoList[todoIndex] = newTodo;
    notifyListeners();
  }

  void deleteTodo(int id) {   
    final todoIndex = todoList.indexWhere(
      (todo) => todo.id == id
      );
    todoList.removeAt(todoIndex);
    notifyListeners();
  }
}
