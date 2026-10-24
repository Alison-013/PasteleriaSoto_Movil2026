
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProveedorInfo {
  final IconData icono;
  final String nombre;
  final String codigo;
  final String detalle;
  final bool activo;

  const ProveedorInfo({
    required this.icono,
    required this.nombre,
    required this.codigo,
    required this.detalle,
    required this.activo,
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
      height: 78,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFE1F1F7),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              proveedor.icono,
              size: 21,
              color: const Color(0xFF315E78),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proveedor.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 13,
                    height: 16 / 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF092535),
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '${proveedor.codigo} • ${proveedor.detalle}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    height: 12 / 9,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7B8B92),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: proveedor.activo
                  ? const Color(0xFFE2F8EF)
                  : const Color(0xFFF3E6E6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              proveedor.activo ? 'Activo' : 'Inactivo',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: proveedor.activo
                    ? const Color(0xFF158260)
                    : const Color(0xFFB04A4A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
