import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginacionProveedores extends StatelessWidget {
  const PaginacionProveedores({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 9),
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
          Text(
            'Página 1 de 3',
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF657278),
            ),
          ),
          const Spacer(),
          const _BotonPaginaProveedores(texto: '‹'),
          const SizedBox(width: 6),
          const _BotonPaginaProveedores(texto: '1', activo: true),
          const SizedBox(width: 6),
          const _BotonPaginaProveedores(texto: '2'),
          const SizedBox(width: 6),
          const _BotonPaginaProveedores(texto: '3'),
          const SizedBox(width: 6),
          const _BotonPaginaProveedores(texto: '›'),
        ],
      ),
    );
  }
}

class _BotonPaginaProveedores extends StatelessWidget {
  final String texto;
  final bool activo;

  const _BotonPaginaProveedores({
    required this.texto,
    this.activo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF092535) : const Color(0xFFF0F3F4),
        shape: BoxShape.circle,
      ),
      child: Text(
        texto,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: activo ? Colors.white : const Color(0xFF526167),
        ),
      ),
    );
  }
}