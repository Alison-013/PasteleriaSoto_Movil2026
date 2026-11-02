import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pasteleria_26/core/di/injection.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'app.routes.dart';
import 'presentation/Screens/login/login_screen.dart';
import 'presentation/Screens/home/home_screen.dart';
import 'presentation/Screens/inventario/inventario_screen.dart';
import 'presentation/Screens/reportes/reportes_screen.dart';
import 'presentation/Screens/actividad/actividad_screen.dart';
import 'presentation/Screens/mas/mas_screen.dart';
import 'presentation/Screens/compras/compras_screen.dart';
import 'presentation/Screens/seguridad/seguridad_screen.dart';
import 'presentation/Screens/proveedores/proveedores_screen.dart';
import 'presentation/Screens/cliente/cliente_screen.dart';
import 'presentation/Screens/perfil/perfil_screen.dart';
import 'presentation/Screens/configuracion/configuracion_screen.dart';
import 'presentation/Screens/reportesCajero/reportesCajero_screen.dart';
import 'presentation/Screens/perfilCajero/perfilCajero_screen.dart';
import 'presentation/Screens/inventarioCajero/inventarioCajero_screen.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/inventory_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/sale_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/activity_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/purchase_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  setUpDependencies();

  getIt<AuthProvider>().checkSession();

  runApp(
    ChangeNotifierProvider(
      create: (_) => getIt<AuthProvider>(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final AuthProvider _authProvider = getIt<AuthProvider>();
  AuthStatus _routedStatus = AuthStatus.unknown;

  @override
  void initState() {
    super.initState();
    _authProvider.addListener(_onAuthChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onAuthChange();
    });
  }

  String _rutaSegunRol(String? rol) {
    final r = (rol ?? '').toLowerCase();

    if (r.contains('admin')) return AppRoutes.home;
    if (r.contains('cajero')) return AppRoutes.inventarioCajero;
    return AppRoutes.login;
  }

  void _onAuthChange() {
    AuthStatus authStatus = _authProvider.authStatus;
    NavigatorState? navigator = _navigatorKey.currentState;

    if (authStatus == _routedStatus || navigator == null) return;
    _routedStatus = authStatus;

    final route = switch (authStatus) {
      AuthStatus.authenticated => _rutaSegunRol(_authProvider.currentUser?.role),
      AuthStatus.unahutenticated => AppRoutes.login,
      AuthStatus.unknown => AppRoutes.splash,
    };

    navigator.pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  void dispose() {
    _authProvider.removeListener(_onAuthChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      initialRoute: AppRoutes.splash,

      routes: <String, WidgetBuilder>{
        AppRoutes.splash: (BuildContext context) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },

        AppRoutes.login: (BuildContext context) {
          return const Login_Screen();
        },

        AppRoutes.home: (BuildContext context) {
          return const Home();
        },

        AppRoutes.inventario: (BuildContext context) {
        return ChangeNotifierProvider(
         create: (_) => getIt<InventoryProvider>()..fetchInventory(),
         child: const InventoryScreen(),
         );
       },

        AppRoutes.reportes: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => getIt<SaleProvider>()..fetchSales(),
            child: const reportes(),
          );
        },

        AppRoutes.actividad: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => getIt<ActivityProvider>()..fetchLogs(),
            child: const Activity_Screen(),
          );
        },
 

        AppRoutes.mas: (BuildContext context) {
          return const Mas_Screen();
        },

        AppRoutes.compras: (BuildContext context) {
          return ChangeNotifierProvider(
            create: (_) => getIt<PurchaseProvider>()..fetchPurchases(),
            child: const Compras_Screen(),
          );
        },

        AppRoutes.seguridad: (BuildContext context) {
          return const seguridad();
        },

        AppRoutes.proveedores: (BuildContext context) {
          return const Proveedores();
        },

        AppRoutes.cliente: (BuildContext context) {
          return const ClienteScreen();
        },

        AppRoutes.perfil: (BuildContext context) {
          return const PerfilScreen();
        },

        AppRoutes.configuracion: (BuildContext context) {
          return const ConfiguracionScreen();
        },

        AppRoutes.reportesCajero: (BuildContext context) {
          return const reportesCajero();
        },

        AppRoutes.perfilCajero: (BuildContext context) {
          return const PerfilCajeroScreen();
        },

        AppRoutes.inventarioCajero: (BuildContext context) {
          return const InventoryCajeroScreen();
        },
      },
    );
  }
}