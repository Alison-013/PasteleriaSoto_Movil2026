import 'package:flutter/material.dart';

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
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ANTERIOR
          InkWell(
            onTap: paginaActual > 1
                ? () => onPaginaSeleccionada(paginaActual - 1)
                : null,
            child: Icon(
              Icons.chevron_left,
              size: 20,
              color: paginaActual > 1
                  ? const Color(0xFF555B60)
                  : const Color(0xFFBFC3C6),
            ),
          ),

          const SizedBox(width: 6),

          // NÚMEROS
          ...List.generate(totalPaginas, (index) {
            final numero = index + 1;
            final activo = paginaActual == numero;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: InkWell(
                onTap: () => onPaginaSeleccionada(numero),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  width: 26,
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: activo
                        ? const Color(0xFF16233F)
                        : const Color(0xFFF1F1F2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    "$numero",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: activo ? FontWeight.w600 : FontWeight.w400,
                      color: activo ? Colors.white : const Color(0xFF555B60),
                    ),
                  ),
                ),
              ),
            );
          }),

          const SizedBox(width: 6),

          // SIGUIENTE
          InkWell(
            onTap: paginaActual < totalPaginas
                ? () => onPaginaSeleccionada(paginaActual + 1)
                : null,
            child: Icon(
              Icons.chevron_right,
              size: 20,
              color: paginaActual < totalPaginas
                  ? const Color(0xFF555B60)
                  : const Color(0xFFBFC3C6),
            ),
          ),
        ],
      ),
    );
  }
}