class Chat {
  Chat({
    this.id,
    this.content,
    
  });

  final int id;
  final String content;


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
     
    };
  }
}