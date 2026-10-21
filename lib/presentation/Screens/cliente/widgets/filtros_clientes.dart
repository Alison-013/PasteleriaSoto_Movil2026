
import 'package:flutter/material.dart';

class FiltroClienteChip extends StatelessWidget {
  final String texto;
  final bool seleccionado;
  final VoidCallback onTap;

  const FiltroClienteChip({
    super.key,
    required this.texto,
    required this.seleccionado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const colorPrincipal = Color(0xFF062B3A);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: seleccionado
              ? colorPrincipal
              : const Color(0xFFE8E8EA),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          texto,
          style: TextStyle(
            fontSize: 9,
            color: seleccionado
                ? Colors.white
                : const Color(0xFF73777B),
          ),
        ),
      ),
    );
  }
}
