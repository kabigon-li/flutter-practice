class ChatRoom {
  ChatRoom({
    this.id,
    this.content,
    this.userId,
    this.lastChat,
    
  });

  final int id;
  final String content;
  final int userId;
  final String lastChat;
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'lastChat': lastChat,
    };
  }
}
