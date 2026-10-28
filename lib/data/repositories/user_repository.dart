import 'package:flutter_pasteleria_26/core/constants/api_constants.dart';
import 'package:flutter_pasteleria_26/core/errors/app_exception.dart';
import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/models/user_model.dart';

class UserRepository { 
  final ApiClient _apiClient;

  UserRepository (this._apiClient);

  Future<UserModel> getById(int id) async {
   final json = await _apiClient.get(ApiConstants.userById(id));
    if (json == null) throw const NotFoundException();
    if (json is! Map<String, dynamic>) throw const ParsingException(); 

   return UserModel.fromJson(json);
  }

  Future<List<UserModel>> search(Map<String, String>? params) async{
    final data = await _apiClient.get(ApiConstants.users, query: params);
    if (data is! List) throw ParsingException();
 
    return data.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
  }

}