class UserModel {
  final int Id;
  final String UserName;
  final String IsActive;
  final String Role;

  UserModel ({
  required this.Id,
  required this.UserName,
  required this.IsActive,
  required this.Role,
  });

  static   UserModel fromJson(Map<String, dynamic> json){
    return UserModel (
      Id: json['Id'] as int,
      UserName: json['UserName'] as String,
      IsActive: json['IsActive'] as String,
      Role: json['Role'] as String,
    );
  }
}

