import 'package:flutter_pasteleria_26/core/constants/regular_expressions.dart';
import 'package:flutter_pasteleria_26/data/models/token_model.dart';
import 'package:flutter_pasteleria_26/data/models/user_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _authRepository;

  AuthService(this._authRepository);

  Future<void> login(String userName, String password) async {
    final trimmedUserName = userName.trim();
    final trimmedPassword = password.trim();

    if (trimmedUserName.isEmpty || trimmedPassword.isEmpty){
      throw const  FormatException ('El usuario y contraseña no puede estar vacio');
    }

    if (!CommonRegex.userNameRegex.hasMatch(trimmedUserName)){
      throw const  FormatException ('Formato invalido para el usuario');
    }

    if (!CommonRegex.passwordRegex.hasMatch(trimmedPassword)){
      throw const  FormatException ('La contraseña debe contener al menos 8 caracteres, incluir una letra mayuscula, una letra minuscula y numeros');
    }

    final TokenModal token = await _authRepository.login(userName, password);
  }


  Future<UserModel> getCurrentUser() async {
    return await _authRepository.currentUser();
  }
  
}