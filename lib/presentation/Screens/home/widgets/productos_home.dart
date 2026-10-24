import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductoDestacado extends StatelessWidget {
  final String nombre;
  final String categoria;
  final String unidades;
  final String imagenUrl;
  final Color color;

  const ProductoDestacado({
    super.key,
    required this.nombre,
    required this.categoria,
    required this.unidades,
    required this.imagenUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      padding: const EdgeInsets.all(7),
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
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.network(imagenUrl, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF263238),
                  ),
                ),
                Text(
                  categoria,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                unidades,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
              Text(
                'uds',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  height: 14 / 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF657278),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}