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
