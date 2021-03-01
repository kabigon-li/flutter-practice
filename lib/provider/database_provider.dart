import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wechat_like_memo/model/todo.dart';

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
    Future<Database> database,
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
  Future<List<Todo>> getTodo(
    Future<Database> database,
  ) async {
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
}
