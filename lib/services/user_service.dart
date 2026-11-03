import 'package:flutter_pasteleria_26/data/models/user_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/user_repository.dart';

class UserService {
  final UserRepository _userRepository;

  const UserService(this._userRepository);

  Future<List<UserModel>> searchUsers(Map<String, String>? params) async {
    return await _userRepository.search(params);
  }
}