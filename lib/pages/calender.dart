import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/provider/database_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';

class Calender extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalenderState();
  }
}

class _CalenderState extends State<Calender> {
  DateTime _currentDate = DateTime.now();

  void onDayPressed(DateTime date, List<Event> events) {
    this.setState(() => _currentDate = date);
    Fluttertoast.showToast(msg: date.toString());
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return new Scaffold(
      appBar: AppBar(
        title: Text("Calender Example"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage(
              //     'image/spring.jpg',
              //   ),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: Column(
            children: [
              CalendarCarousel<Event>(
                onDayPressed: onDayPressed,
                weekendTextStyle: TextStyle(color: Colors.red),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: 420.0,
                selectedDateTime: _currentDate,
                daysHaveCircularBorder: false,
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                markedDateShowIcon: true,
                markedDateIconMaxShown: 2,
                todayTextStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                ),
                markedDateIconBuilder: (event) {
                  return event.icon;
                },
                todayBorderColor: Colors.green,
                markedDateMoreShowTotal: false,
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'image/backnote.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView.builder(
                  //physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                  itemCount: todoProvider.todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: todo(
                        // 1. Todo(id: 0, content: 'k', isChecked: 0)
                        // 2. Todo(id: 1, content: 'kabigon', isChecked: 0)
                        todoProvider
                            .todoList[index], //调用todo这个方法时，这获取画面中更新的每行Todo
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget todo(
    // Todo(id: 0, content: 'k', isChecked: 0)
    Todo todoNew, //这接收新一个Todo
  ) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //显示在屏幕上的每一条todo，由打沟框，todo内容，和删除按钮组成
          GestureDetector(
            onTap: () {
              updateBottomSheet(
                //例えば、カビゴン書いたら、ここに渡す
                todoNew.id, //获取第一行的id，0
                todoNew.isChecked, //获取第一行的是否勾选
              );
            },
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  child: Text(
                    todoNew.content,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      // decoration: todoNew.isChecked == 0
                      //     ? null
                      //     : TextDecoration.lineThrough,
                    ),
                  ),
                ),
              ),
            ),
          ),

          //分割线
          const Divider(
            height: 2,
            thickness: 1,
            color: Colors.grey,
            indent: 100,
            endIndent: 100,
          ),
        ],
      ),
    );
  }

  void deleteTodoSheet(int index) {
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

//updateBottom接收
  void updateBottomSheet(int index, int f) {
    //index受け取る
    // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                //width: size.width,
                child: Row(
                  //Row Column中・二個か二個以上widgetの間隙間決める
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ColoredBox(
                        color: Colors.white,
                        child: TextFormField(
                          maxLines: 20,
                          //initialValue: text,
                          // onChanged: (String t) {
                          //   chatbox(t);
                          // },
                          decoration: InputDecoration(
                            hintText: 'to do',
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 60,
                      child: ElevatedButton(
                        child: Text('編集'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                        ),
                        onPressed: () {
                          //クタスの実体化、Todoをtodoに代入
                          Todo newTodo = Todo(
                            id: index,
                            //content: text,
                            isChecked: f,
                          );
                          todoProvider.updateTodo(
                            //1, 渡す 0
                            index,
                            newTodo,
                          );
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
