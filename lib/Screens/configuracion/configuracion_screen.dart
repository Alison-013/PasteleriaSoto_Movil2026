import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'package:google_fonts/google_fonts.dart';
import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';
import 'widgets/perfil_configuracion.dart';

class ConfiguracionScreen extends StatelessWidget {
  const ConfiguracionScreen({super.key});

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
      backgroundColor: const Color(0xFFFAF9FA),

      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  12,
                  14,
                  16,
                ),
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.chevron_left,
                            size: 15,
                            color: Color(0xFF486878),
                          ),
                          Text(
                            'Más Opciones',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF486878),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Configuración',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF092535),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      'Administra los detalles de tu pastelería.',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 11,
                        color: const Color(0xFF52585C),
                      ),
                    ),

                    const SizedBox(height: 35),

                    const PerfilUsuarioCard(),

                    const SizedBox(height: 49),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _mostrarConfirmacionCerrarSesion(context);
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 16,
                        ),
                        label: Text(
                          'Cerrar Sesión',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFE32626),
                          backgroundColor: const Color(0xFFF7E7E7),
                          side: const BorderSide(
                            color: Color(0xFFF1C5C5),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
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

      bottomNavigationBar: const menu_Widget(
        currentIndex: 4,
      ),
    );
  }
}
