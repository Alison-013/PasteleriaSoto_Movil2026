import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants{
 String get baseUrl => dotenv.env['BASE_API_URL'] ?? '';
 String get enviroment => dotenv.env['ENVIROMENT'] ?? '';

 ApiConstants._privateConstructor();
 static final ApiConstants _instance = ApiConstants._privateConstructor();
 static ApiConstants get instance => _instance;

  // Auth (POST) AND Auth (GET)
  static const String login = '/auth';
  static const String me = '/auth/me';   

  // Listados (GET)
  static const String users = '/users';
  static const String products = '/products';
  static const String categories = '/categories';
  static const String customers = '/customers';
  static const String suppliers = '/suppliers';
  static const String inventory = '/inventory';
  static const String sales = '/sales';
  static const String purchases = '/purchases';
  static const String invoices = '/invoices';
  static const String orders = '/orders';
  static const String personalizedProducts = '/personalizedproducts';
  static const String options = '/options';
  static const String auditLogs = '/auditlogs'; 

  // Casos especiales (GET)
  static const String ordersByDate = '/orders/byDate';
  static const String unprintedInvoices = '/invoices/unprinted';

  // Detalle por id (GET)
  static String userById(int id) => '/users/$id';
  static String productById(int id) => '/products/$id';
  static String categoryById(int id) => '/categories/$id';
  static String customerById(int id) => '/customers/$id';
  static String supplierById(int id) => '/suppliers/$id';
  static String inventoryById(int id) => '/inventory/$id';
  static String inventoryByProductId(int productId) => '/inventory/product/$productId';
  static String inventoryByProductName(String name) => '/inventory/product/name/${Uri.encodeComponent(name)}';
  static String saleById(int id) => '/sales/$id';
  static String purchaseById(int id) => '/purchases/$id';
  static String invoiceById(int id) => '/invoices/$id';
  static String orderById(int id) => '/orders/$id';
  static String personalizedProductById(int id) => '/personalizedproducts/$id';
  static String optionById(int id) => '/options/$id';


  static const Duration timeoutDuration = Duration(seconds: 30);

}
