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
        const SizedBox(width: 10),
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
          const SizedBox(width: 10),
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
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: activo ? const Color(0xFF16233F) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: activo ? const Color(0xFF16233F) : const Color(0xFFE0E4EA),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icono != null) ...[
              Icon(
                icono,
                size: 18,
                color: activo ? Colors.white : Colors.grey,
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                texto,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 12,
                  color: activo ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}