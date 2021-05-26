import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wechat_like_memo/model/chat.dart';
import 'package:wechat_like_memo/model/fontSize.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/model/timeline.dart';

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

  //userを追加する(create)
  Future<void> insertUser({
    User user,
  }) async {
    final Database db = await database;
    await db.insert(
      // tableの名前
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //userを取得する(read)
// getUserのreturnしたデータ型はlist<User>
  Future<List<User>> getUser() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('users');
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
      'users',
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
      'users',
      user.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [user.id],
    );
  }

  //chatを追加する(create)
  Future<void> insertChat({
    Chat chat,
  }) async {
    final Database db = await database;
    await db.insert(
      // tableの名前
      'chat',
      chat.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //chatを取得する(read)
// getChatのreturnしたデータ型はlist<Chat>
  Future<List<Chat>> getChat() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('chat');
    return List.generate(maps.length, (i) {
      return Chat(
        id: maps[i]['id'],
        content: maps[i]['content'],
        userId: maps[i]['userId'],
        isLeft: maps[i]['isLeft'],
        createdAt: maps[i]['createdAt'],
        isImage: maps[i]['isImage'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  // delete chat
  Future<void> deleteChat(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'chat',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> updateChat(
    Chat chat,
  ) async {
    final Database db = await database;
    await db.update(
      'chat',
      chat.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [chat.id],
    );
  }

  //timelineを追加する(create)
  Future<void> insertTimeLine({TimeLine timeLine}) async {
    final Database db = await database;
    await db.insert(
      // tableの名前
      'timeline',
      timeLine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //timelineを取得する(read)
// getChatのreturnしたデータ型はlist<Chat>
  Future<List<TimeLine>> getTimeLine() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('timeline');
    return List.generate(maps.length, (i) {
      return TimeLine(
        id: maps[i]['id'],
        content: maps[i]['content'],
        imagePath: maps[i]['imagePath'],
        color: maps[i]['color'],
      );
    });
  }

  // delete chat
  Future<void> deleteTimeLine(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'timeline',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> updateTimeLine(
    TimeLine timeline,
  ) async {
    final Database db = await database;
    await db.update(
      'timeline',
      timeline.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [timeline.id],
    );
  }

  Future<List<FontSize>> getFontSize() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('fontSize');
    return List.generate(maps.length, (i) {
      return FontSize(
        fontSize: maps[i]['fontSize'],
      );
    });
  }

  //timelineを追加する(create)
  Future<void> insertFontSize({FontSize fontSize}) async {
    final Database db = await database;
    await db.insert(
      // tableの名前
      'fontSize',
      fontSize.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
