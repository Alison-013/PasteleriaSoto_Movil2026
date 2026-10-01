import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'package:google_fonts/google_fonts.dart';

class PerfilUsuarioCard extends StatelessWidget {
  const PerfilUsuarioCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(7),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.perfil);
        },
        borderRadius: BorderRadius.circular(7),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD5DADF)),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E7E9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.storefront,
                  size: 18,
                  color: Color(0xFF062B3A),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perfil de Usuario',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF092535),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Gestiona tus datos personales y seguridad.',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        height: 1.4,
                        color: const Color(0xFF4E565B),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: Color(0xFFB9C2C7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}