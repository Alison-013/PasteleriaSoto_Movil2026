import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltrosReportes extends StatelessWidget {
  final List<String> filtros;
  final int filtroActivo;
  final ValueChanged<int> onSeleccionar;

  const FiltrosReportes({
    super.key,
    required this.filtros,
    required this.filtroActivo,
    required this.onSeleccionar,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filtros.length,
        separatorBuilder: (_, __) => const SizedBox(width: 7),
        itemBuilder: (context, index) {
          final activo = filtroActivo == index;

          return InkWell(
            onTap: () => onSeleccionar(index),
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: activo ? const Color(0xFF092535) : Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: activo
                      ? const Color(0xFF092535)
                      : const Color(0xFFDDE2E5),
                ),
              ),
              child: Text(
                filtros[index],
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  height: 14 / 11,
                  fontWeight: FontWeight.w500,
                  color: activo
                      ? Colors.white
                      : const Color(0xFF526167),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}