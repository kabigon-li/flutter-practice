import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';
import 'package:wechat_like_memo/tab/tab.dart';

import 'model/todo.dart';
import 'route/route.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final Future<Database> database = openDatabase(
  //   join(await getDatabasesPath(), 'todo_database.db'),
  //   onCreate: (db, version) {
  //     return db.execute(
  //       "CREATE TABLE todo(id INTEGER PRIMARY KEY, content TEXT, ischecked INTEGER)",
  //     );
  //   },
  //   version: 1,
  // );

  // final todo1 = Todo(
  //   id: 0,
  //   content: 'kabigon',
  //   isChecked: 0,
  // );
  // final todo2 = Todo(
  //   id: 1,
  //   content: 'kabigon-2',
  //   isChecked: 0,
  // );
  // insertTodo(database, todo1);
  // insertTodo(database, todo2);

  // 使いたいProviderをここに書く
  runApp(
    (MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(
            todoList: [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(
            chatList: [],
          ),
        ),
      ],
      child: MyApp(),
    )),
  );
}

Future<void> insertTodo(
  Future<Database> database,
  Todo todo,
) async {
  final Database db = await database;
  await db.insert(
    'todo',
    todo.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wechat_like_memo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TabScreen(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
