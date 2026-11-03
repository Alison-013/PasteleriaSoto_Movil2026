import 'dart:convert';

class TokenModal{
  final int userId;
  final String userName;
  final String token;
  final String role;
  final DateTime expiresAt;

  TokenModal({
    required this.userId,
    required this.userName,
    required this.token,
    required this.role,
    required this.expiresAt,
  });
  
  bool get isTokenExpired => DateTime.now().isAfter(expiresAt);

  static TokenModal fromJson(Map<String, dynamic> json) {
     final token = json['token'] as String;
    return TokenModal(
      userId: json['userId'],
      userName: json['userName'],
      token: json['token'],
      role: json['role'],
      expiresAt: _expirationFromToken(token),
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

   // Lee la fecha de vencimiento (claim "exp") que viene dentro del JWT
  static DateTime _expirationFromToken(String token) {
    final payload = token.split('.')[1];
    final data = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(payload))),
    );
    return DateTime.fromMillisecondsSinceEpoch((data['exp'] as int) * 1000);
  }
}
