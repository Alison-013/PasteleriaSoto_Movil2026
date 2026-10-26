class TokenModal{
  final int userId;
  final String userName;
  final String token;
  final String role;

  TokenModal({
    required this.userId,
    required this.userName,
    required this.token,
    required this.role,
  });

  static TokenModal fromJson(Map<String, dynamic> json) {
    return TokenModal(
      userId: json['userId'],
      userName: json['userName'],
      token: json['token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'token': token,
      'role': role,
    };
  }
}
