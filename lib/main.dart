import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wechat_like_memo/provider/appTheme_provider.dart';
import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
import 'package:wechat_like_memo/tab/tab.dart';

import 'model/todo.dart';
import 'route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQlite datebase: todo テーブルの作成
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),

    // 初期定義を行う（初期化）
    onCreate: (db, version) {
      return db.execute(
        //tableの中身、todoはテーブルの名前
        "CREATE TABLE todo(id INTEGER PRIMARY KEY, content TEXT, ischecked INTEGER)",
      );
    },

    // 更新する時、２になる、次の更新３になる、毎回増える
    version: 1,
  );

  //todoListはreturnしたやつを代入(read)
  final todoList = await getTodo(database);

  // 使いたいProviderをここに書く
  runApp(
    (MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // データベースから持ってきたtodoをtodoproviderに渡す
          // Providerの初期化
          create: (_) => TodoProvider(
            todoList: todoList,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(
            chatList: [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TimelineProvider(
            timelineList: [],
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => SeasonsMode(
            isImageSelected: false,
            selectedImageNumber: 100,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DataBaseProvider(
            database: database,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(
            isLogined: false,
            userList: [],
          ),
        ),
      ],
      child: MyApp(),
    )),
  );
}

//todoを取得する(read)
// getTodoのreturnしたデータ型はlist<Todo>
Future<List<Todo>> getTodo(
  Future<Database> database,
) async {
  //　database 本体をdbに代入
  final Database db = await database;

  // databaseからtodoの全部アプリに持ってくる
  final List<Map<String, dynamic>> maps = await db.query('todo');

  //Map<String, dynamic>からTodo型に変換
  return List.generate(maps.length, (i) {
    return Todo(
      id: maps[i]['id'],
      content: maps[i]['content'],
      isChecked: maps[i]['isChecked'],
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wechat_like_memo',
      theme: Provider.of<AppTheme>(context).buildTheme(),
      home: TabScreen(),
      onGenerateRoute: onGenerateRoute,
    );
  }
}
