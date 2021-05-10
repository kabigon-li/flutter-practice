import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/model/user.dart';

class DataBaseProvider with ChangeNotifier {
  DataBaseProvider({
    this.database,
  });

  Future<Database> database;

  Future<Database> getDatabaseInfo() {
    return database;
  }

//todoを追加する(create)
  Future<void> insertTodo({
    Todo todo,
  }) async {
    final Database db = await database;
    await db.insert(
      // tableの名前
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//todoを取得する(read)
// getTodoのreturnしたデータ型はlist<Todo>
  Future<List<Todo>> getTodo() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        content: maps[i]['content'],
        isChecked: maps[i]['isChecked'],
      );
    });
  }

  // delete chat room
  Future<void> deleteTodo(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'todo',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> updateTodo(
    Todo todo,
  ) async {
    final Database db = await database;
    await db.update(
      'todo',
      todo.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

  //userを取得する(read)
// getUserのreturnしたデータ型はlist<User>
  Future<List<User>> getUser() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        isLogined: maps[i]['isLogined'],
        userName: maps[i]['userName'],
        userImage: maps[i]['userImage'],
      );
    });
  }

  // delete chat room
  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'user',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> updateUser(
    User user,
  ) async {
    final Database db = await database;
    await db.update(
      'user',
      user.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }
}
