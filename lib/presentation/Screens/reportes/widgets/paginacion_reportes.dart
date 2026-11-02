import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginacionReportes extends StatelessWidget {
 final int paginaActual;
 final int totalPaginas;
 final ValueChanged<int> onCambiarPagina;

 const PaginacionReportes({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onCambiarPagina,
  });
 
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
        Text(
          'Página $paginaActual de $totalPaginas',
          style: _estiloCaption(const Color(0xFF526167)),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: paginaActual > 1
              ? () => onCambiarPagina(paginaActual - 1)
              : null,
          child: Icon(
            Icons.chevron_left,
            size: 18,
            color: paginaActual > 1
                ? const Color(0xFF526167)
                : const Color(0xFFC5CBCE),
          ),
        ),
        const SizedBox(width: 6),
        for (int i = 1; i <= totalPaginas; i++) ...[
          InkWell(
            onTap: () => onCambiarPagina(i),
            child: _BotonPagina(texto: '$i', activo: i == paginaActual),
          ),
          const SizedBox(width: 6),
        ],
        InkWell(
          onTap: paginaActual < totalPaginas
              ? () => onCambiarPagina(paginaActual + 1)
              : null,
          child: Icon(
            Icons.chevron_right,
            size: 18,
            color: paginaActual < totalPaginas
                ? const Color(0xFF526167)
                : const Color(0xFFC5CBCE),
          ),
        ),
      ],
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