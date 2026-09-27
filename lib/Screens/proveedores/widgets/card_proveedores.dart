import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProveedorInfo {
  final IconData icono;
  final String nombre;
  final String codigo;
  final String detalle;

  const ProveedorInfo({
    required this.icono,
    required this.nombre,
    required this.codigo,
    required this.detalle,
  });
}

class CardProveedor extends StatelessWidget {
  final ProveedorInfo proveedor;

  const CardProveedor({
    super.key,
    required this.proveedor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFE1F1F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              proveedor.icono,
              size: 18,
              color: const Color(0xFF315E78),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proveedor.nombre,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    height: 15 / 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF092535),
                  ),
                ),
                Text(
                  '${proveedor.codigo} • ${proveedor.detalle}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    height: 11 / 8,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7B8B92),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F8EF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Activo',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF158260),
              ),
            ),
          ),
        ],
      ),
    );
  }
}