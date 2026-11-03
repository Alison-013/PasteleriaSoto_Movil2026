class UserModel {
  final int id;
  final String userName;
  final bool isActive;
  final String role;

  UserModel ({
  required this.id,
  required this.userName,
  required this.isActive,
  required this.role,
  });

 static UserModel fromJson(Map<String, dynamic> json){
    return UserModel (
      id: json['id'] as int,
      userName: json['userName'] as String,
      isActive: json['isActive'] as bool,
      role: json['role'] as String,
    );
  }
}

