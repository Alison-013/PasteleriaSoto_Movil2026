import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/user_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/user_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'widgets/drawer_seguridad.dart';
import 'widgets/card_seguridad.dart';
import 'widgets/infousuario_seguridad.dart';

class seguridad extends StatelessWidget {
  const seguridad({super.key});

  final List<Color> _colores = const [
    Color(0xFFB98264),
    Color(0xFF8FA6B6),
    Color(0xFFCE8755),
    Color(0xFFBC976C),
    Color(0xFF6F8391),
    Color(0xFFE3C4B4),
  ];

  String _iniciales(String nombre) {
    final partes = nombre
        .trim()
        .split(RegExp(r'[\s._-]+'))
        .where((p) => p.isNotEmpty)
        .toList();

    if (partes.isEmpty) return '?';
    if (partes.length == 1) {
      final p = partes.first;
      return (p.length >= 2 ? p.substring(0, 2) : p).toUpperCase();
    }
    return '${partes[0][0]}${partes[1][0]}'.toUpperCase();
  }

  UsuarioInfo _aUsuarioInfo(UserModel usuario) {
    return UsuarioInfo(
      usuario.userName,
      usuario.role,
      _iniciales(usuario.userName),
      _colores[usuario.id % _colores.length],
      usuario.isActive,
    );
  }

  void _abrirPermisos(BuildContext context, UsuarioInfo usuario) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DrawerPermisos(usuario: usuario),
    );
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UserProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const TopBar_Widget(),

              Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // RUTA
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.mas,
                      ),

                      child: Row(
                        children: const [
                          Text(
                            "Más Opciones",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Colors.grey,
                          ),

                          Text(
                            "Seguridad",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // TITULO
                    Row(
                      children: [
                        const Text(
                          "Seguridad",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF1F5),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Text(
                            "${users.users.length} total",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Gestión de usuarios y permisos de acceso.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // LISTA DE USUARIOS
                    if (users.viewStatus == ViewStatus.loading)

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(child: CircularProgressIndicator()),
                      )

                    else if (users.viewStatus == ViewStatus.error)

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                users.errorMessage ?? "Ocurrió un error.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () =>
                                    context.read<UserProvider>().fetchUsers(),
                                child: const Text("Reintentar"),
                              ),
                            ],
                          ),
                        ),
                      )

                    else if (users.users.isEmpty)

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),

                        child: Center(
                          child: Text(
                            "No se encontraron usuarios.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )

                    else

                      Column(
                        children: users.users.map((user) {
                          final usuario = _aUsuarioInfo(user);

                          return TarjetaUsuario(
                            usuario: usuario,
                            onTap: () => _abrirPermisos(context, usuario),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const menu_Widget(currentIndex: 4),
    );
  }
}