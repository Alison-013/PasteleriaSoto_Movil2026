import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginacionReportes extends StatelessWidget {
  const PaginacionReportes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 12),
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
          Text(
            'Página 1 de 3',
            style: _estiloCaption(const Color(0xFF526167)),
          ),
          const Spacer(),
          const _BotonPagina(texto: '‹'),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '1', activo: true),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '2'),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '3'),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '›'),
        ],
      ),
    );
  }
}

class _BotonPagina extends StatelessWidget {
  final String texto;
  final bool activo;

  const _BotonPagina({
    required this.texto,
    this.activo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 21,
      height: 21,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF092535) : const Color(0xFFF0F2F3),
        shape: BoxShape.circle,
      ),
      child: Text(
        texto,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: activo ? Colors.white : const Color(0xFF526167),
        ),
      ),
    );
  }
}

TextStyle _estiloCaption(Color color) {
  return GoogleFonts.poppins(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w500,
    color: color,
  );
}