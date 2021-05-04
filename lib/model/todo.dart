class Todo {
  Todo({
    this.id,
    this.content,
    this.isChecked,
  });

  final int id;
  final String content;
  final int isChecked; // 0 == false, 1 == true

  Todo copyWith({
    int id,
    String content,
    int isChecked,
  }) {
    return Todo(
      id: id ?? this.id,
      content: content ?? this.content,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isChecked': isChecked,
    };
  }
}
