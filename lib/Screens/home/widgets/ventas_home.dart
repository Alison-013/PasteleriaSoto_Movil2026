import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VentaReciente extends StatelessWidget {
  final String orden;
  final String cliente;
  final String precio;
  final String estado;
  final Color colorEstado;

  const VentaReciente({
    super.key,
    required this.orden,
    required this.cliente,
    required this.precio,
    required this.estado,
    required this.colorEstado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
          const CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xFFF0F2F3),
            child: Icon(
              Icons.person_outline,
              size: 16,
              color: Color(0xFF4E595F),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orden,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF657278),
                  ),
                ),
                Text(
                  cliente,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF263238),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                precio,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
              Container(
                color: colorEstado,
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2,
                ),
                child: Text(
                  estado,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF356379),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}