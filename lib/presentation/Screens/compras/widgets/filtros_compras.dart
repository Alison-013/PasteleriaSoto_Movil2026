import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/reportes_formato.dart';
import 'filtro_dropdown.dart';
 
class FiltrosCompras extends StatelessWidget {
  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final String proveedorSeleccionado;
  final List<FiltroOpcion> opcionesProveedor; 
  final VoidCallback onElegirInicio;
  final VoidCallback onElegirFin;
  final ValueChanged<String> onSeleccionarProveedor;
  final VoidCallback onLimpiar;
 
  const FiltrosCompras({
    super.key,
    required this.fechaInicio,
    required this.fechaFin,
    required this.proveedorSeleccionado,
    required this.opcionesProveedor,
    required this.onElegirInicio,
    required this.onElegirFin,
    required this.onSeleccionarProveedor,
    required this.onLimpiar,
  });
 
  @override
  Widget build(BuildContext context) {
    final hayFiltro = fechaInicio != null ||
        fechaFin != null ||
        proveedorSeleccionado != "Todos";
 
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // FECHA DE INICIO
        _ChipFecha(
          texto: fechaInicio != null
              ? "Inicio: ${formatearFecha(fechaInicio!)}"
              : "Inicio",
          activo: fechaInicio != null,
          onTap: onElegirInicio,
        ),
 
        // FECHA DE FIN
        _ChipFecha(
          texto: fechaFin != null
              ? "Fin: ${formatearFecha(fechaFin!)}"
              : "Fin",
          activo: fechaFin != null,
          onTap: onElegirFin,
        ),
 
        // PROVEEDOR
        FiltroDropdownWidget(
          titulo: "Proveedor",
          opciones: opcionesProveedor,
          seleccionado: proveedorSeleccionado,
          onSeleccionar: onSeleccionarProveedor,
        ),
 
        // BOTÓN PARA LIMPIAR
        if (hayFiltro)
          GestureDetector(
            onTap: onLimpiar,
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.close,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
 
class _ChipFecha extends StatelessWidget {
  final String texto;
  final bool activo;
  final VoidCallback onTap;
 
  const _ChipFecha({
    required this.texto,
    required this.activo,
    required this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: activo ? const Color(0xFF16233F) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: activo ? const Color(0xFF16233F) : const Color(0xFFE0E4EA),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 14,
              color: activo ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              texto,
              style: TextStyle(
                color: activo ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}