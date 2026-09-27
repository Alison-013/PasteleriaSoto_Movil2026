import 'package:flutter/material.dart';
import 'app.routes.dart';

import '/Screens/login/login_screen.dart';
import '/Screens/home/home_screen.dart';
import '/Screens/inventario/inventario_screen.dart';
import '/Screens/reportes/reportes_screen.dart';
import '/Screens/actividad/actividad_screen.dart';
import '/Screens/mas/mas_screen.dart';
import '/Screens/compras/compras_screen.dart';
import '/Screens/seguridad/seguridad_screen.dart';
import '/Screens/proveedores/proveedores_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.login,

     routes: <String, WidgetBuilder>{
  AppRoutes.login: (BuildContext context) {
    return const Login_Screen();
  },

  AppRoutes.home: (BuildContext context) {
    return const Home();
  },

  AppRoutes.inventario: (BuildContext context) {
    return const InventoryScreen();
  },

  AppRoutes.reportes: (BuildContext context) {
    return const reportes();
  },

  AppRoutes.actividad: (BuildContext context) {
    return const Activity_Screen();
  },

  AppRoutes.mas: (BuildContext context) {
    return const Mas_Screen();
  },

  AppRoutes.compras: (BuildContext context) {
    return const Compras_Screen();
  },


  AppRoutes.seguridad: (BuildContext context) {
    return const seguridad();
  },

   AppRoutes.proveedores: (BuildContext context) {
   return const Proveedores();
  },
},
    );
  }
}

void main() {
  runApp(const MainApp());
}