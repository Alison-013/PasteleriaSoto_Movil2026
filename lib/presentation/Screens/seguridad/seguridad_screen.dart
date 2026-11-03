import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/user_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/user_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'widgets/drawer_seguridad.dart';
import 'widgets/estilos_seguridad.dart';
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

  // Iniciales: "maria gomez" -> MG, "admin" -> AD
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
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.mas,
                        );
                      },
                      child: estiloTextoVolver(),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Seguridad',
                      style: estiloPlayfairSeguridad(17, FontWeight.w400),
                    ),
                    Text(
                      'Gestión de usuarios y permisos de acceso',
                      style: estiloPoppinsSeguridad(
                        10,
                        const Color(0xFF657278),
                        FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 14),
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
                                users.errorMessage ?? 'Ocurrió un error.',
                                textAlign: TextAlign.center,
                                style: estiloPoppinsSeguridad(
                                  10,
                                  Colors.red,
                                  FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () =>
                                    context.read<UserProvider>().fetchUsers(),
                                child: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (users.users.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text(
                            'No se encontraron usuarios.',
                            style: estiloPoppinsSeguridad(
                              10,
                              const Color(0xFF657278),
                              FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    else
                      ...users.users.map((user) {
                        final usuario = _aUsuarioInfo(user);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: TarjetaUsuario(
                            usuario: usuario,
                            onTap: () => _abrirPermisos(context, usuario),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const menu_Widget(currentIndex: 4),
    );
  }

  Widget estiloTextoVolver() {
    return Text(
      'Más opciones > Seguridad',
      style: estiloPoppinsSeguridad(
        9,
        const Color(0xFF486878),
        FontWeight.w500,
      ),
    );
  }
}