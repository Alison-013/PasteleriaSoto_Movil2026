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
    final Map<int, UserModel> todos = {};
    int pagina = 1;
    int totalPaginas = 1;

    do {
      final data = await _apiClient.get(
        ApiConstants.users,
        query: {...?params, 'PageNumber': '$pagina', 'PageSize': '50'},
      );

      List items;
      if (data is List) {
        items = data;
      } else if (data is Map<String, dynamic> && data['value'] is Map<String, dynamic>) {
        final value = data['value'] as Map<String, dynamic>;
        if (value['items'] is! List) throw const ParsingException();
        items = value['items'] as List;
        totalPaginas = (value['totalPages'] ?? 1) as int;
      } else {
        throw const ParsingException();
      }

      for (final item in items) {
        final u = UserModel.fromJson(item as Map<String, dynamic>);
        todos[u.id] = u;
      }

      pagina++;
    } while (pagina <= totalPaginas);

    return todos.values.toList();
  }

  Future<void> update (int id,Map<String, String> data ) async {
   await _apiClient.put('${ApiConstants.users}/$id', body: data);
  }

  Future<void> delete(int id) async {
   await _apiClient.delete('${ApiConstants.users}/$id');
  }

  Future<UserModel> create(Map<String, dynamic> data) async {
    final json = await _apiClient.post(ApiConstants.users, body: data);
    if (json is! Map<String, dynamic>) throw ParsingException();

    return UserModel.fromJson(json);
  }
}