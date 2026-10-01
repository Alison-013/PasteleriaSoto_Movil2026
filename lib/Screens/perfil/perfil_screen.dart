import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';

import '/Widgets/menu_Widget.dart';

import 'widgets/opcion_perfil.dart';
import 'widgets/card_perfil.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEF9FE),
      body: SafeArea(
        child: Column(
          children: [
            // Franja superior azul oscuro.
            Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xFF062B3A),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.configuracion,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.chevron_left,
                            size: 15,
                            color: Color(0xFF486878),
                          ),
                          Text(
                            'Configuración',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF486878),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TarjetaPerfil(),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'Ajustes de Cuenta',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color(0xFF092535),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      width: 151,
                      height: 2,
                      margin: const EdgeInsets.only(top: 3, bottom: 12),
                      color: const Color(0xFFF1B744),
                    ),
                    const OpcionPerfil(
                      icono: Icons.manage_accounts_outlined,
                      titulo: 'Editar Perfil',
                      descripcion: 'Modifica tus datos personales',
                    ),
                    const SizedBox(height: 12),
                    const OpcionPerfil(
                      icono: Icons.key_outlined,
                      titulo: 'Cambiar Contraseña',
                      descripcion: 'Actualiza tu clave de acceso',
                    ),
                    const SizedBox(height: 12),
                    const OpcionPerfil(
                      icono: Icons.notifications,
                      titulo: 'Notificaciones',
                      descripcion: 'Preferencias de alertas',
                    ),
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
}