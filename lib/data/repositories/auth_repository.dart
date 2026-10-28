import 'package:flutter_pasteleria_26/core/constants/api_constants.dart';
import 'package:flutter_pasteleria_26/core/errors/app_exception.dart';
import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/models/token_model.dart';
import 'package:flutter_pasteleria_26/data/models/user_model.dart';

class AuthRepository { 
  final ApiClient _apiClient;

  AuthRepository (this._apiClient);

  Future<TokenModal> login(String userName, String password) async {
    final json = await _apiClient.post(
      ApiConstants.login,
      body: {'UserName': userName, 'Password': password},
    );

    if (json is! Map<String, dynamic>) throw ParsingException();

    return TokenModal.fromJson(json);
  }

  Future<UserModel> currentUser() async{
    final json = await _apiClient.get(ApiConstants.me);
    
    if (json == null) throw const UnauthorizedExsception();
    if (json is! Map<String, dynamic>) throw const ParsingException(); 
 
    return UserModel.fromJson(json);
  }

}