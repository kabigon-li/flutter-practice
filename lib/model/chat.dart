class Chat {
  Chat({
    this.id,
    this.content,
    this.userId,
    this.isLeft,
    this.createdAt,
    this.isImage,
    this.imagePath,
  });

  final int id;
  final String content;
  final int userId;
  final int isLeft;
  final String createdAt;
  final int isImage;
  final String imagePath;

  Chat copyWith({
    int id,
    String content,
    int userId,
    int isLeft,
    String createdAt,
    int isImage,
    String imagePath,
  }) {
    return Chat(
      //idもし指定されなかったら、そのままのid
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      isLeft: isLeft ?? this.isLeft,
      createdAt: createdAt ?? this.createdAt,
      isImage: isImage ?? this.isImage,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'isLeft': isLeft,
      'createdAt': createdAt,
      'isImage': isImage,
      'imagePath': imagePath,
    };
  }
}
