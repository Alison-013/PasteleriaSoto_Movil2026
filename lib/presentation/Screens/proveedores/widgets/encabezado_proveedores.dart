import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'package:google_fonts/google_fonts.dart';

class EncabezadoProveedores extends StatelessWidget {
  const EncabezadoProveedores({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.mas);
              },
              child: Text(
                'Más Opciones',
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF8A8F92),
                ),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              size: 13,
              color: Color(0xFF8A8F92),
            ),
            const SizedBox(width: 4),
            Text(
              'Proveedores',
              style: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF25282A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Expanded(
              child: Text(
                'Proveedores',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F1F9),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '18 total',
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF315E78),
                ),
              ),
            ),
          ],
        ),
        Text(
          'Consulta de proveedores de la pastelería.',
          style: GoogleFonts.poppins(
            fontSize: 10,
            height: 14 / 10,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF657278),
          ),
        ),
      ],
    );
  }
}