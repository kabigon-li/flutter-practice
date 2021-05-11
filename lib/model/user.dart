class User {
  User({
    this.id,
    this.isLogined,
    this.userImage,
    this.userName,
  });

  final int id;
  final int isLogined;
  final String userImage;
  final String userName;
 
  User copyWith({
    int id,
    int isLogined,
    String userImage,
    String userName,
  }) {
    return User(
      id: id ?? this.id,
      isLogined: isLogined ?? this.isLogined,
      userImage: userImage ?? this.userImage,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isLogined': isLogined,
      'userImage': userImage,
      'userName': userName,
    };
  }
}
