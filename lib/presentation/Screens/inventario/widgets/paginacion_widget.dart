import 'package:flutter/material.dart';

/// Paginación funcional: permite tocar un número de página o usar las
/// flechas para avanzar/retroceder. Las flechas se desactivan en los extremos.
class PaginacionWidget extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;
  final ValueChanged<int> onCambiarPagina;

  const PaginacionWidget({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onCambiarPagina,
  });

  Widget _numeroPagina(int numero) {
    final activo = numero == paginaActual;
    return GestureDetector(
      onTap: activo ? null : () => onCambiarPagina(numero),
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activo ? const Color(0xFF16233F) : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0E4EA)),
        ),
        child: Text(
          "$numero",
          style: TextStyle(color: activo ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final puedeAnterior = paginaActual > 1;
    final puedeSiguiente = paginaActual < totalPaginas;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Página $paginaActual de $totalPaginas", style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: puedeAnterior ? () => onCambiarPagina(paginaActual - 1) : null,
          child: Icon(
            Icons.chevron_left,
            color: puedeAnterior ? Colors.black87 : Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 8),
        for (int i = 1; i <= totalPaginas; i++) ...[
          _numeroPagina(i),
          if (i != totalPaginas) const SizedBox(width: 8),
        ],
        const SizedBox(width: 8),
        GestureDetector(
          onTap: puedeSiguiente ? () => onCambiarPagina(paginaActual + 1) : null,
          child: Icon(
            Icons.chevron_right,
            color: puedeSiguiente ? Colors.black87 : Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}