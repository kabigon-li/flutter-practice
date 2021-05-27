import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/chat.dart';
import 'package:wechat_like_memo/model/colorTheme.dart';

import 'package:wechat_like_memo/model/fontSize.dart';
import 'package:wechat_like_memo/model/user.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';
import 'package:wechat_like_memo/provider/appTheme_provider.dart';
import 'package:wechat_like_memo/provider/chat_provider.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/font_size_provider.dart';
import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/provider/timeline_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';
import 'package:wechat_like_memo/provider/user_provider.dart';
import 'package:wechat_like_memo/tab/tab.dart';

import 'package:wechat_like_memo/model/timeline.dart';
import 'model/todo.dart';
import 'route/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SQlite datebase: todo テーブルの作成
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),

    // 初期定義を行う（初期化）
    onCreate: (db, version) {
      db.execute(
        //tableの中身、todoはテーブルの名前
        "CREATE TABLE todo(id INTEGER PRIMARY KEY, content TEXT, isChecked INTEGER)",
      );
      db.execute(
        //tableの中身、usersはテーブルの名前
        "CREATE TABLE users(id INTEGER PRIMARY KEY, isLogined INTEGER, userName INTEGER, userImage INTEGER)",
      );
      db.execute(
        //tableの中身、chatはテーブルの名前
        "CREATE TABLE chat(id INTEGER PRIMARY KEY, content TEXT, userId INTEGER, isLeft INTEGER, createdAt TEXT, isImage INTEGER, imagePath INTEGER)",
      );
      db.execute(
        //tableの中身、timelineはテーブルの名前
        "CREATE TABLE timeline(id INTEGER PRIMARY KEY, content TEXT, imagePath INTEGER, color INTEGER)",
      );
      db.execute(
        //fontSizeの中身、fontSizeはテーブルの名前
        "CREATE TABLE fontSize(fontSize INTEGER)",
      );
      db.execute(
        
        "CREATE TABLE colorTheme(colorTheme INTEGER)",
      );
    },

    // 更新する時、２になる、次の更新３になる、毎回増える
    version: 1,
  );

  //默认用户
  // final defaultUser = User(
  //   id: 0,
  //   userName: 'my user',
  //   isLogined: 0,
  // );
  // insertUser(
  //   user: defaultUser,
  //   database: database,
  // );

  //todoListはreturnしたやつを代入(read)
  final todoList = await getTodo(database);
  final userList = await getUser(database);
  final chatList = await getChat(database);
  final timelineList = await getTimeLine(database);
  final fontSizeList = await getFontSize(database);
  final colorList = await getColorTheme(database);
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
            chatList: chatList,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => TimelineProvider(
            timelineList: timelineList,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AppTheme(),
        ),
        ChangeNotifierProvider(
          create: (_) => FontSizeProvider(
            fontSize:20.0,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ColorThemeProvider(
          colorList: colorList,
          ),
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
            userList: userList,
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

Future<void> insertUser({
  Future<Database> database,
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

//User datebase 5/10
Future<List<User>> getUser(
  Future<Database> database,
) async {
  //　database 本体をdbに代入
  final Database db = await database;

  // databaseからtodoの全部アプリに持ってくる
  final List<Map<String, dynamic>> maps = await db.query('users');

  //Map<String, dynamic>からTodo型に変換
  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      isLogined: maps[i]['isLogined'],
      userName: maps[i]['userName'],
      userImage: maps[i]['userImage'],
    );
  });
}

//Chat database 5/14
Future<List<Chat>> getChat(
  Future<Database> database,
) async {
  //　database 本体をdbに代入
  final Database db = await database;

  // databaseからtodoの全部アプリに持ってくる
  final List<Map<String, dynamic>> maps = await db.query('chat');

  //Map<String, dynamic>からTodo型に変換
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

//timeline database 5/18
Future<List<TimeLine>> getTimeLine(
  Future<Database> database,
) async {
  //　database 本体をdbに代入
  final Database db = await database;

  // databaseからtimelineの全部アプリに持ってくる
  final List<Map<String, dynamic>> maps = await db.query('timeline');

  //Map<String, dynamic>からTodo型に変換
  return List.generate(maps.length, (i) {
    return TimeLine(
      id: maps[i]['id'],
      content: maps[i]['content'],
      imagePath: maps[i]['imagePath'],
      color: maps[i]['color'],
    );
  });
}

Future<List<FontSize>> getFontSize(
  Future<Database> database,
) async {
  //　database 本体をdbに代入
  final Database db = await database;

  // databaseからtodoの全部アプリに持ってくる
  final List<Map<String, dynamic>> maps = await db.query('fontSize');

  //Map<String, dynamic>からTodo型に変換
  return List.generate(maps.length, (i) {
    return FontSize(
      fontSize: maps[i]['fontSize'],
     
    );
  });
}

Future<List<ColorTheme>> getColorTheme(
  Future<Database> database,
) async {
  //　database 本体をdbに代入
  final Database db = await database;

  // databaseからtodoの全部アプリに持ってくる
  final List<Map<String, dynamic>> maps = await db.query('colorTheme');

  //Map<String, dynamic>からTodo型に変換
  return List.generate(maps.length, (i) {
    return ColorTheme( 
      colorTheme: maps[i]['colorTheme'],
     
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
