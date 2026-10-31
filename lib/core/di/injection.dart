import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/repositories/auth_repository.dart';
import 'package:flutter_pasteleria_26/data/repositories/token_repository.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/auth_provider.dart';
import 'package:flutter_pasteleria_26/services/auth_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpDependencies (){

 getIt.registerLazySingleton <ApiClient>(()=> ApiClient(), dispose:(client) => client.dispose());

 //Registrar repositorios
 getIt.registerLazySingleton<AuthRepository>(()=> AuthRepository(getIt<ApiClient>()));
 getIt.registerLazySingleton<TokenRepository>(()=> TokenRepository());

 //Registrar servicios
 getIt.registerLazySingleton<AuthService>(()=> AuthService(getIt<AuthRepository>(), getIt<TokenRepository>()));

 //Registrar providers
 getIt.registerLazySingleton<AuthProvider>(()=> AuthProvider(getIt<AuthService>()));

}
