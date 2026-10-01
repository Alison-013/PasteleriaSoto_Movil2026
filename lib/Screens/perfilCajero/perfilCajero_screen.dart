
import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/Widgets/cajeroMenu_Widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'widgets/opcion_perfil.dart';
import 'widgets/card_perfil.dart';

class PerfilCajeroScreen extends StatelessWidget {
  const PerfilCajeroScreen({super.key});

  // Confirmación para cerrar sesión
  void _mostrarConfirmacionCerrarSesion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            '¿Cerrar sesión?',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF092535),
            ),
          ),
          content: Text(
            '¿Estás seguro de que deseas cerrar sesión?',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF52585C),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancelar',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF657278),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
              child: Text(
                'Cerrar sesión',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFE32626),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
                      margin: const EdgeInsets.only(
                        top: 3,
                        bottom: 12,
                      ),
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

                    const SizedBox(height: 20),

                    // Botón Cerrar sesión
                    InkWell(
                      onTap: () {
                        _mostrarConfirmacionCerrarSesion(context);
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFFFD6D6),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              size: 23,
                              color: Color(0xFFE32626),
                            ),

                            const SizedBox(width: 12),

                            Text(
                              'Cerrar sesión',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE32626),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Menú inferior del cajero
      bottomNavigationBar: const cajeroMenu_Widget(
        currentIndex: 2,
      ),
    );
  }
}
