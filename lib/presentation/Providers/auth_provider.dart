import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/errors/app_exception.dart';
import 'package:flutter_pasteleria_26/data/models/user_model.dart';
import 'package:flutter_pasteleria_26/services/auth_service.dart';

enum AuthStatus {
  authenticated,
  unahutenticated,
  unknown,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;
  AuthProvider(this._authService);

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthStatus _authStatus = AuthStatus.unknown;

  AuthStatus get authStatus => _authStatus;

  bool get isAuthenticated => _authStatus == AuthStatus.authenticated;
  bool _isSubmitting = false;
  bool get isSubmitting => _isSubmitting;


  Future<void> login ({required String userName, required String password}) async {
    if (_isSubmitting) return;

    _isSubmitting = true;
    notifyListeners();

   
    try {
      UserModel user = await _authService.login(userName, password);
      _authStatus = AuthStatus.authenticated;
      _currentUser = user;
    } on AppException catch (e){
      _errorMessage = e.message;
    } on FormatException catch (e){
      _errorMessage = e.message;
    }  catch (e) {
     
      _errorMessage = 'ocurrio un error inesperado. Porfavor intente de nuevo.';
   }

    _isSubmitting = false;
    notifyListeners();
    
  }

  Future <void> checkSession () async {
    try {
      final bool isAuthenticated = await _authService.isLoggedIn();
      if (isAuthenticated) {
        _currentUser = await _authService.getCurrentUser();
      }
      _authStatus = isAuthenticated
      ? AuthStatus.authenticated
      : AuthStatus.unahutenticated;
    } catch (e){
      _errorMessage = 'Ocurrio un error inesperado. Porfavor intente de nuevo';
      _authStatus = AuthStatus.unahutenticated;
    } finally {
      notifyListeners();
    }
  } 

  Future<void> logout() async {
    await _authService.logout();
    _authStatus = AuthStatus.unahutenticated;
    _currentUser = null;
    _errorMessage = null;
    notifyListeners();
  }
}
  
