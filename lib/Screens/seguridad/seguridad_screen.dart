import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';

import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';

import 'widgets/drawer_seguridad.dart';
import 'widgets/estilos_seguridad.dart';
import 'widgets/card_seguridad.dart';
import 'widgets/infousuario_seguridad.dart';

class seguridad extends StatelessWidget {
  const seguridad({super.key});

  final List<UsuarioInfo> usuarios = const [
    UsuarioInfo('María Gómez', 'Administrador', 'MG', Color(0xFFB98264)),
    UsuarioInfo('Carlos Ruiz', 'Vendedor', 'CR', Color(0xFF8FA6B6)),
    UsuarioInfo('Ana Morales', 'Cajera', 'AM', Color(0xFFCE8755)),
    UsuarioInfo('Javier Soto', 'Administrador', 'JS', Color(0xFFBC976C)),
    UsuarioInfo('Kevin Marenco', 'Cajero', 'KM', Color(0xFF6F8391)),
    UsuarioInfo('Elena Rostrán', 'Cajera', 'ER', Color(0xFFE3C4B4)),
  ];

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
                    ...usuarios.map((usuario) {
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