import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Filtro de reportes por fecha.
/// - [filtrosRapidos]: ej. ['Hoy', 'Ayer', 'Esta semana'].
/// - [filtroActivo]: cuál de los anteriores está seleccionado, o 'Personalizada'
///   cuando el usuario eligió una fecha específica del calendario.
/// - [fechaSeleccionada]: la fecha elegida cuando filtroActivo == 'Personalizada'.
///
/// Los accesos rápidos se estiran con Expanded para ocupar todo el ancho
/// disponible (antes quedaba mucho espacio vacío a la derecha porque eran
/// chips pequeños dentro de un scroll horizontal).
class FiltrosReportes extends StatelessWidget {
  final List<String> filtrosRapidos;
  final String filtroActivo;
  final DateTime? fechaSeleccionada;
  final ValueChanged<String> onSeleccionarRapido;
  final VoidCallback onElegirFecha;

  const FiltrosReportes({
    super.key,
    required this.filtrosRapidos,
    required this.filtroActivo,
    required this.fechaSeleccionada,
    required this.onSeleccionarRapido,
    required this.onElegirFecha,
  });

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day.toString().padLeft(2, '0');
    final mes = fecha.month.toString().padLeft(2, '0');
    return '$dia/$mes/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    final personalizadaActiva = filtroActivo == 'Personalizada';

    return Row(
      children: [
        for (final filtro in filtrosRapidos) ...[
          Expanded(
            child: _ChipFiltro(
              texto: filtro,
              activo: filtroActivo == filtro,
              onTap: () => onSeleccionarRapido(filtro),
            ),
          ),
          const SizedBox(width: 7),
        ],
        _ChipFiltro(
          texto: personalizadaActiva && fechaSeleccionada != null
              ? _formatearFecha(fechaSeleccionada!)
              : 'Fecha',
          activo: personalizadaActiva,
          icono: Icons.calendar_today_rounded,
          onTap: onElegirFecha,
        ),
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
            Text(
              texto,
              style: GoogleFonts.poppins(
                fontSize: 11,
                height: 14 / 11,
                fontWeight: FontWeight.w500,
                color: activo ? Colors.white : const Color(0xFF526167),
              ),
            ),
          ],
        ),
      ),
    );
  }
}