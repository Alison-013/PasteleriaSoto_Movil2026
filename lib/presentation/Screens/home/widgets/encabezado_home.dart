import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EncabezadoSeccion extends StatelessWidget {
  final String titulo;
  final String? accion;

  const EncabezadoSeccion({
    super.key,
    required this.titulo,
    this.accion,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: GoogleFonts.playfairDisplay(
              fontSize: 17,
              height: 24 / 17,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF092535),
            ),
          ),
        ),
        if (accion != null)
          Text(
            accion!,
            style: GoogleFonts.poppins(
              fontSize: 11,
              height: 14 / 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF547183),
            ),
          ),
      ],
    );
  }
}