
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaginacionProveedores extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;
  final ValueChanged<int> onPaginaSeleccionada;

  const PaginacionProveedores({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onPaginaSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPaginas <= 1) {
      return const SizedBox.shrink();
    }

    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Página $paginaActual de $totalPaginas',
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF657278),
            ),
          ),

          const SizedBox(width: 10),

          _BotonPaginaProveedores(
            texto: '‹',
            habilitado: paginaActual > 1,
            onTap: paginaActual > 1
                ? () => onPaginaSeleccionada(paginaActual - 1)
                : null,
          ),

          const SizedBox(width: 6),

          ...List.generate(
            totalPaginas,
            (index) {
              final pagina = index + 1;

              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: _BotonPaginaProveedores(
                  texto: '$pagina',
                  activo: paginaActual == pagina,
                  onTap: () => onPaginaSeleccionada(pagina),
                ),
              );
            },
          ),

          _BotonPaginaProveedores(
            texto: '›',
            habilitado: paginaActual < totalPaginas,
            onTap: paginaActual < totalPaginas
                ? () => onPaginaSeleccionada(paginaActual + 1)
                : null,
          ),
        ],
      ),
    );
  }
}

class _BotonPaginaProveedores extends StatelessWidget {
  final String texto;
  final bool activo;
  final bool habilitado;
  final VoidCallback? onTap;

  const _BotonPaginaProveedores({
    required this.texto,
    this.activo = false,
    this.habilitado = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: habilitado ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 30,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activo
              ? const Color(0xFF092535)
              : const Color(0xFFF0F3F4),
          shape: BoxShape.circle,
        ),
        child: Text(
          texto,
          style: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: activo
                ? Colors.white
                : habilitado
                    ? const Color(0xFF526167)
                    : const Color(0xFFB8C0C5),
          ),
        ),
      ),
    );
  }
}
