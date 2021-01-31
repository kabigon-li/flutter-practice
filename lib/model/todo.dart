class Todo {
  Todo({
    this.id,
    this.content,
    this.isChecked,
  });

  final int id;
  final String content;
  final int isChecked; // 0 == false, 1 == true

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isChecked': isChecked,
    };
  }
}