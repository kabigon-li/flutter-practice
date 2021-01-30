import 'package:flutter/material.dart';

import 'package:wechat_like_memo/model/timeline.dart';

class TimelineProvider with ChangeNotifier {
  TimelineProvider({
    this.timelineList,
  });

  List<Timeline> timelineList;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  //クラス中の関数
  void addTimeline(
    Timeline timeline, //受け取りたいやつ
  ) {
    timelineList.add(timeline);
    notifyListeners();
  }

  void updateTimeline(
    //2, うけとる
    int id,
    Timeline newTimeline,
    Image picture,
    Color color,
  ) {
    final timelineIndex = timelineList.indexWhere(
      (timeline) => timeline.id == id,
    );
    timelineList[timelineIndex] = newTimeline;
    notifyListeners();
  }

  void deletechat(int id) {
    final timelineIndex = timelineList.indexWhere((chat) => chat.id == id);
    timelineList.removeAt(timelineIndex);
    notifyListeners();
  }
}
