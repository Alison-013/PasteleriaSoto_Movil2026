import 'package:flutter/material.dart';

/// Paginación de la lista de productos. Por ahora sigue siendo solo visual,
/// igual que en la versión original; se dejó como widget aparte para no
/// repetir este bloque si se usa en otras listas de la app.
class PaginacionWidget extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;

  const PaginacionWidget({
    super.key,
    this.paginaActual = 1,
    this.totalPaginas = 3,
  });

  Widget _numeroPagina(int numero) {
    final activo = numero == paginaActual;
    return Container(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Página $paginaActual de $totalPaginas", style: const TextStyle(color: Colors.grey)),
        const SizedBox(width: 12),
        const Icon(Icons.chevron_left, color: Colors.grey),
        const SizedBox(width: 8),
        for (int i = 1; i <= totalPaginas; i++) ...[
          _numeroPagina(i),
          if (i != totalPaginas) const SizedBox(width: 8),
        ],
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, color: Colors.grey),
      ],
    );
  }
}