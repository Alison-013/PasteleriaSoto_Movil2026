import 'dart:convert';

import 'package:flutter_pasteleria_26/data/models/token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  final SharedPreferencesAsync _sharedPreferences = SharedPreferencesAsync();
  final String _tokenKey = 'auth_token';

  Future<void> saveToken(TokenModal token) async{
   final String jsonString = jsonEncode(token.toJson());
   await _sharedPreferences.setString(_tokenKey, jsonString);
  }

  Future<TokenModal?> getToken() async{
    final String? rawJson = await _sharedPreferences.getString(_tokenKey);
    if (rawJson == null) return null;

    try {
      final Map<String, dynamic> jsonMap = jsonDecode(rawJson);
      final token = TokenModal.fromJson(jsonMap);
      if(token.isTokenExpired){
        await removeToken();
        return null;
      }
    }
    catch (e) {
     await removeToken();
    }
    return null;

  }
  Future<void> removeToken () async{
    await _sharedPreferences.remove(_tokenKey);
  }
}