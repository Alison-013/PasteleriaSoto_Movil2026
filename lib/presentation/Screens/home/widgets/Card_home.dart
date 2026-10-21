import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TarjetaResumen extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String cantidad;

  const TarjetaResumen({
    super.key,
    required this.icono,
    required this.titulo,
    required this.cantidad,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F1F9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icono,
              size: 16,
              color: const Color(0xFF356379),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cantidad,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF092535),
                  ),
                ),
                Text(
                  titulo,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF657278),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}