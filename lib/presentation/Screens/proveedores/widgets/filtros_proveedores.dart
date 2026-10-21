
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DIRECTORIO REGISTRADO',
          style: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8A989E),
          ),
        ),

        const SizedBox(height: 7),

        SizedBox(
          height: 28,
          child: Row(
            children: List.generate(
              filtros.length,
              (index) {
                final seleccionado = filtroActivo == index;

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == filtros.length - 1 ? 0 : 7,
                  ),
                  child: InkWell(
                    onTap: () => onSeleccionar(index),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: seleccionado
                            ? const Color(0xFF092535)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: seleccionado
                              ? const Color(0xFF092535)
                              : const Color(0xFFDCE3E7),
                        ),
                      ),
                      child: Text(
                        filtros[index],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: seleccionado
                              ? Colors.white
                              : const Color(0xFF657278),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
