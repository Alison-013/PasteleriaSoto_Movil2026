import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pasteleria_26/core/constants/reportes_formato.dart';


class FiltrosReportes extends StatelessWidget {
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final VoidCallback onElegirInicio;
  final VoidCallback onElegirFin;
  final VoidCallback onLimpiar;
 

  const FiltrosReportes({
    super.key,
    required this.fechaInicio,
    required this.fechaFin,
    required this.onElegirInicio,
    required this.onElegirFin,
    required this.onLimpiar,
  });

  @override
  Widget build(BuildContext context) {
    final hayFiltro = fechaInicio != null || fechaFin != null;

    return Row(
      children: [
          Expanded(
            child: _ChipFiltro(
              texto: fechaInicio != null
                ? 'Inicio: ${formatearFecha(fechaInicio!)}'
                : 'Inicio',
                activo: fechaInicio != null,
                icono: Icons.calendar_today_rounded,
                onTap: onElegirInicio,
            ),
          ),
          const SizedBox(width: 7),
           Expanded(
          child: _ChipFiltro(
            texto: fechaFin != null
                ? 'Fin: ${formatearFecha(fechaFin!)}'
                : 'Fin',
            activo: fechaFin != null,
            icono: Icons.calendar_today_rounded,
            onTap: onElegirFin,
          ),
        ),
        if (hayFiltro) ...[
          const SizedBox(width: 7),
          _ChipFiltro(
            texto: 'Limpiar',
            activo: false,
            icono: Icons.close_rounded,
            onTap: onLimpiar,
          ),
        ],
        ],
    );
  }
}

class _ChipFiltro extends StatelessWidget {
  final String texto;
  final bool activo;
  final IconData? icono;
  final VoidCallback onTap;

  const _ChipFiltro({
    required this.texto,
    required this.activo,
    required this.onTap,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activo ? const Color(0xFF092535) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: activo ? const Color(0xFF092535) : const Color(0xFFDDE2E5),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icono != null) ...[
              Icon(
                icono,
                size: 13,
                color: activo ? Colors.white : const Color(0xFF526167),
              ),
              const SizedBox(width: 5),
            ],
            Flexible(
              child: Text(
                texto,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  height: 14 / 11,
                  fontWeight: FontWeight.w500,
                  color: activo ? Colors.white : const Color(0xFF526167),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}