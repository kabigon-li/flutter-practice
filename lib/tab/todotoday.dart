import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat_like_memo/constant/constants.dart';
import 'package:wechat_like_memo/model/todo.dart';
import 'package:wechat_like_memo/provider/ColorTheme%20_provider.dart';
import 'package:wechat_like_memo/provider/font_size_provider.dart';

import 'package:wechat_like_memo/provider/settings_provider.dart';
import 'package:wechat_like_memo/provider/todo_provider.dart';

import 'package:wechat_like_memo/tab/todotoday_notifier.dart';

class TodoTaday extends StatelessWidget {
  const TodoTaday({
    Key key,
    this.isNavigateFromDrawer = false,
  });

  // 受け取りたい値
  final bool isNavigateFromDrawer;

  static String routeName = 'todo-today-screen';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Notifier作成
      create: (_) => TodoTodayNotifier(
        context: context,
        isNavigateFromDrawer: isNavigateFromDrawer,
      ),
      child: _TodoTaday(),
    );
  }
}

class _TodoTaday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TodoTodayNotifier>(context, listen: false);
    final season = Provider.of<SeasonsMode>(context);

    // 当todoprovider中的todolist中内容的改变，要呈现画面上的改变时，listen为true
    final todoProvider = Provider.of<TodoProvider>(context);
    final colorThemeProvider = Provider.of<ColorThemeProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:  colorList[colorThemeProvider.selectedColorNumber ?? 4],
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: fontColor,
        // ),
        title: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'To do',
              style: TextStyle(
                  fontFamily: 'iconfont', fontSize: 22, color: fontColor),
            ),
          ),
        ),
      ),
      body: Stack(children: [
        // Stackの中のやつ使える
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              //color: Color.fromRGBO(212, 241, 248, 1),
              // image: season.isImageSelected
              //     ? DecorationImage(
              //         image: AssetImage(
              //           imageList[season.selectedImageNumber],
              //         ),
              //         fit: BoxFit.cover,
              //       )
              //     : DecorationImage(
                      
              //         fit: BoxFit.cover,
              //       ),

            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true, // 高さ関連のエラーが出たら、使う
                      itemCount: todoProvider.todoList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return todo(
                          context,
                          // 1. Todo(id: 0, content: 'k', isChecked: 0)
                          // 2. Todo(id: 1, content: 'kabigon', isChecked: 0)
                          todoProvider
                              .todoList[index], //调用todo这个方法时，这获取画面中更新的每行Todo
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
      //右下角添加新的todo
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:30.0,right:10,),
        child: Align(
          alignment: Alignment.bottomRight,
                child: FloatingActionButton(
            backgroundColor: Colors.grey[400],
            child: Icon(Icons.add_box,color: Colors.grey[600],),
            onPressed: () {
              return addTodo(context);
            },
          ),
        ),
      ),
    );
  }

  Widget todo(
    // Todo(id: 0, content: 'k', isChecked: 0)
    BuildContext context,
    Todo todoNew, //这接收新一个Todo
  ) {
    final notifier = Provider.of<TodoTodayNotifier>(context, listen: false);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //显示在屏幕上的每一条todo，由打沟框，todo内容，和删除按钮组成
        Card(
          color: Colors.grey[200],
          child: CheckboxListTile(
            // 1.右边打勾框
            
            activeColor: Colors.blue,
            value: todoNew.isChecked == 0 ? false : true,
            onChanged: (value) {
              notifier.updateCheckBox(todoNew);
            },

            // 2. todo内容部分
            title: SizedBox(
              //height: 20,
              //クリック編集
              child: GestureDetector(
                onTap: () {
                  updateBottomSheet(
                    context,
                    //例えば、カビゴン書いたら、ここに渡す
                    todoNew, //获取第一行的id，0
                    //获取第一行的是否勾选
                  );
                },
                child: Text(
                  todoNew.content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSizeProvider.fontSize,
                    decoration: todoNew.isChecked == 0
                        ? null
                        : TextDecoration.lineThrough,
                  ),
                ),
              ),
            ),

            // 3. 删除按钮
            secondary: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                //todoNew.id
                deleteTodoSheet(context, todoNew.id);
              },
            ),
          ),
        ),

        // 4. 分割线
        const Divider(
          height: 2,
          thickness: 1,
          color: Colors.grey,
          indent: 10,
          // endIndent: 20,
        ),
      ],
    );
  }

//编辑todo时上弹输入框
  void updateBottomSheet(
    BuildContext context,
    Todo todoNew,
  ) {
    //index受け取る
    // TodoProviderクラスのインスタンス(コピー)を変数に代入
    final notifier = Provider.of<TodoTodayNotifier>(context, listen: false);
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
                          initialValue: notifier.text,
                          onChanged: (String t) {
                            notifier.chatbox(t);
                          },
                          decoration: InputDecoration(
                            hintText: todoNew.content,
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
                          notifier.updateTodoContent(todoNew);
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

//添加新的todo
  void addTodo(BuildContext context) {
    final notifier = Provider.of<TodoTodayNotifier>(context, listen: false);
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
                height: 50,
                //width: size.width,
                child: Row(
                  //Row Column中・二個か二個以上widgetの間隙間決める
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      //height: 200,
                      width: 200,
                      child: ColoredBox(
                        color: Colors.white,
                        child: TextField(
                          maxLines: 20,
                          onChanged: (String t) {
                            notifier.chatbox(t);
                          },
                          decoration: InputDecoration(
                            hintText: 'White a new to do !',
                            contentPadding: const EdgeInsets.all(10),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: SizedBox(
                        height: 50,
                        width: 80,
                        child: ElevatedButton(
                          child: Text('add',style:TextStyle(fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(130, 176, 104,1),
                          ),
                          onPressed: notifier.addTodo,
                        ),
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

  void deleteTodoSheet(
    BuildContext context,
    int index,
  ) {
    final notifier = Provider.of<TodoTodayNotifier>(context, listen: false);
    notifier.deleteTodo(index);
  }
}
