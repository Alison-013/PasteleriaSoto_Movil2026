import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpcionPerfil extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String descripcion;
  final VoidCallback? onTap;

  const OpcionPerfil({
    super.key,
    required this.icono,
    required this.titulo,
    required this.descripcion,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  icono,
                  size: 18,
                  color: const Color(0xFF092535),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF22292D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      descripcion,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xFF596167),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 19,
                color: Color(0xFF778187),
              ),
            ],
          ),
        ),
      ),
    );
  }
}