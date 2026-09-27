import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle estiloPoppinsSeguridad(
  double tamanio,
  Color color,
  FontWeight peso,
) {
  return GoogleFonts.poppins(
    fontSize: tamanio,
    fontWeight: peso,
    color: color,
  );
}

TextStyle estiloPlayfairSeguridad(
  double tamanio,
  FontWeight peso,
) {
  return GoogleFonts.playfairDisplay(
    fontSize: tamanio,
    fontWeight: peso,
    color: const Color(0xFF092535),
  );
}

BoxDecoration cajaSeguridad({
  Color borde = Colors.transparent,
  bool sombra = true,
}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: borde),
    boxShadow: sombra
        ? const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]
        : [],
  );
}