import 'package:flutter/material.dart';

import 'package:wechat_like_memo/model/timeline.dart';

class TimelineProvider with ChangeNotifier {
  TimelineProvider({
    this.timelineList,
  });

  List<TimeLine> timelineList;

  // 追加、削除、更新、取得
  // Create, Read, Update, Delete == CRUD

  //クラス中の関数
  void addTimeline(
    TimeLine timeline, //受け取りたいやつ
  ) {
    timelineList.add(timeline);
    notifyListeners();
  }

  void updateTimeline(
    //2, うけとる
    int id,
    TimeLine newTimeline,
    Image picture,
    Color color,
  ) {
    final timelineIndex = timelineList.indexWhere(
      (timeline) => timeline.id == id,
    );
    timelineList[timelineIndex] = newTimeline;
    notifyListeners();
  }

  void deleteTimeline(int id) {
    final timelineIndex = timelineList.indexWhere((timeline) => timeline.id == id);
    timelineList.removeAt(timelineIndex);
    notifyListeners();
  }
}
