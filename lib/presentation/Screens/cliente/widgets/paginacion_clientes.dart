
import 'package:flutter/material.dart';

class PaginadorClientes extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;
  final ValueChanged<int> onCambiarPagina;

  const PaginadorClientes({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onCambiarPagina,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Página anterior
          _BotonPagina(
            icono: Icons.chevron_left,
            seleccionado: false,
            habilitado: paginaActual > 1,
            onTap: () {
              if (paginaActual > 1) {
                onCambiarPagina(paginaActual - 1);
              }
            },
          ),

          const SizedBox(width: 4),

          // Números de páginas
          ...List.generate(totalPaginas, (index) {
            final numero = index + 1;

            return Padding(
              padding: const EdgeInsets.only(left: 4),
              child: _BotonPagina(
                texto: '$numero',
                seleccionado: paginaActual == numero,
                habilitado: true,
                onTap: () => onCambiarPagina(numero),
              ),
            );
          }),

          const SizedBox(width: 4),

          // Página siguiente
          _BotonPagina(
            icono: Icons.chevron_right,
            seleccionado: false,
            habilitado: paginaActual < totalPaginas,
            onTap: () {
              if (paginaActual < totalPaginas) {
                onCambiarPagina(paginaActual + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BotonPagina extends StatelessWidget {
  final String? texto;
  final IconData? icono;
  final bool seleccionado;
  final bool habilitado;
  final VoidCallback onTap;

  const _BotonPagina({
    this.texto,
    this.icono,
    required this.seleccionado,
    required this.habilitado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: habilitado ? onTap : null,
      borderRadius: BorderRadius.circular(6),

      child: Container(
        width: 26,
        height: 26,
        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: seleccionado
              ? const Color(0xFF062B3A)
              : const Color(0xFFF1F1F2),
          borderRadius: BorderRadius.circular(6),
        ),

        child: texto != null
            ? Text(
                texto!,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      seleccionado ? FontWeight.w600 : FontWeight.w400,
                  color: seleccionado
                      ? Colors.white
                      : const Color(0xFF555B60),
                ),
              )
            : Icon(
                icono,
                size: 16,
                color: habilitado
                    ? const Color(0xFF555B60)
                    : const Color(0xFFBFC3C6),
              ),
      ),
    );
  }
}