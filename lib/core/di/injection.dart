import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/repositories/auth_repository.dart';
import 'package:flutter_pasteleria_26/data/repositories/inventory_repository.dart';
import 'package:flutter_pasteleria_26/data/repositories/product_repository.dart';
import 'package:flutter_pasteleria_26/data/repositories/token_repository.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/auth_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/inventory_provider.dart';
import 'package:flutter_pasteleria_26/services/auth_service.dart';
import 'package:flutter_pasteleria_26/services/inventory_service.dart';
import 'package:flutter_pasteleria_26/services/product_service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_pasteleria_26/data/repositories/sale_repository.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/sale_provider.dart';
import 'package:flutter_pasteleria_26/services/sale_service.dart';
import 'package:flutter_pasteleria_26/data/repositories/audit_log_repository.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/activity_provider.dart';
import 'package:flutter_pasteleria_26/services/audit_log_service.dart';
import 'package:flutter_pasteleria_26/data/repositories/purchase_repository.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/purchase_provider.dart';
import 'package:flutter_pasteleria_26/services/purchase_service.dart';
 

final getIt = GetIt.instance;

void setUpDependencies (){

 getIt.registerLazySingleton <ApiClient>(
   () => ApiClient(authTokenProvider: () => getIt<TokenRepository>().getToken()),
   dispose: (client) => client.dispose(),
 );
 
 //Registrar repositorios
 getIt.registerLazySingleton<AuthRepository>(()=> AuthRepository(getIt<ApiClient>()));
 getIt.registerLazySingleton<TokenRepository>(()=> TokenRepository());
 getIt.registerLazySingleton<InventoryRepository>(()=> InventoryRepository(getIt<ApiClient>()));
 getIt.registerLazySingleton<ProductRepository>(()=> ProductRepository(getIt<ApiClient>()));
 getIt.registerLazySingleton<SaleRepository>(()=> SaleRepository(getIt<ApiClient>()));
 getIt.registerLazySingleton<AuditLogRepository>(()=> AuditLogRepository(getIt<ApiClient>()));
 getIt.registerLazySingleton<PurchaseRepository>(()=> PurchaseRepository(getIt<ApiClient>()));

 //Registrar servicios
 getIt.registerLazySingleton<AuthService>(()=> AuthService(getIt<AuthRepository>(), getIt<TokenRepository>()));
 getIt.registerLazySingleton<InventoryService>(()=> InventoryService(getIt<InventoryRepository>()));
 getIt.registerLazySingleton<ProductService>(()=> ProductService(getIt<ProductRepository>()));
 getIt.registerLazySingleton<SaleService>(()=> SaleService(getIt<SaleRepository>()));
 getIt.registerLazySingleton<AuditLogService>(()=> AuditLogService(getIt<AuditLogRepository>()));
 getIt.registerLazySingleton<PurchaseService>(()=> PurchaseService(getIt<PurchaseRepository>()));


 //Registrar providers
 getIt.registerLazySingleton<AuthProvider>(()=> AuthProvider(getIt<AuthService>()));
 getIt.registerFactory<InventoryProvider>(()=> InventoryProvider(getIt<InventoryService>(), getIt<ProductService>()));
 getIt.registerFactory<SaleProvider>(()=> SaleProvider(getIt<SaleService>()));
 getIt.registerFactory<ActivityProvider>(()=> ActivityProvider(getIt<AuditLogService>()));
 getIt.registerFactory<PurchaseProvider>(()=> PurchaseProvider(getIt<PurchaseService>()));

}



