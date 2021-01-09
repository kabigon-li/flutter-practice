import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/todo.dart';

class TodoProvider with ChangeNotifier {
  TodoProvider({
    this.todoList,
  });

  List<Todo> todoList;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  // getter for all todoList
  List<Todo> get todosList {
    return [...todoList];
  }

  // 追加する - 関数呼ぶ
  // final todo = Todo(
  //   id: 0,
  //   content: 'kabigon',
  //
  // );
  // addTodo(todo);

  void addTodo(
    Todo todo, //受け取りたいやつ
  ) {
    todoList.add(todo);
    notifyListeners();
  }

  // Future<void> updateTweet(int id, Todo newTodo) async {
  //   final chatIndex = todoList.indexWhere((tweet) => tweet.id == id);

  //   todoList[chatIndex] = newTodo;
  //   notifyListeners();
  // }

  // Future<void> deleteTweet(int id) async {
  //   final existingChatIndex = todoList.indexWhere((tweet) => tweet.id == id);
  //   todoList.removeAt(existingChatIndex);
  //   notifyListeners();
  // }
}
