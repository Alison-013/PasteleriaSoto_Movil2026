import 'package:flutter/material.dart';

class FiltrosProveedores extends StatelessWidget {
  final List<String> filtros;
  final int filtroActivo;
  final ValueChanged<int> onSeleccionar;

  const FiltrosProveedores({
    super.key,
    required this.filtros,
    required this.filtroActivo,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(filtros.length, (index) {
        final activo = filtroActivo == index;

        return GestureDetector(
          onTap: () => onSeleccionar(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: activo ? const Color(0xFF16233F) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: activo ? const Color(0xFF16233F) : const Color(0xFFE0E4EA),
              ),
            ),
            child: Text(
              filtros[index],
              style: TextStyle(
                color: activo ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        );
      }),
    );
  }
}