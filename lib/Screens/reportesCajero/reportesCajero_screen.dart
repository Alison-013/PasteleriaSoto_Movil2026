import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/Widgets/cajeroMenu_Widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '/Widgets/TopBar_Cajero.dart';
import 'widgets/detalle_reportes.dart';
import 'widgets/filtros_reportes.dart';
import 'widgets/ingresos_reportes.dart';
import 'widgets/paginacion_reportes.dart';
import 'widgets/total_reportes.dart';

class reportesCajero extends StatefulWidget {
  const reportesCajero({super.key});

  @override
  State<reportesCajero> createState() => _ReportesState();
}

class _ReportesState extends State<reportesCajero> {
  // Filtro activo: 'Hoy' | 'Ayer' | 'Esta semana' | 'Personalizada'
  String _filtroActivo = 'Hoy';
  DateTime? _fechaSeleccionada;

  final List<String> _filtrosRapidos = const [
    'Hoy',
    'Ayer',
    'Esta semana',
  ];

  Future<void> _elegirFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF092535),
            ),
          ),
          child: child!,
        );
      },
    );

    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
        _filtroActivo = 'Personalizada';
      });
    }
  }

  void _seleccionarRapido(String filtro) {
    setState(() {
      _filtroActivo = filtro;
      _fechaSeleccionada = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Cajero(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Alto disponible real (restando el padding vertical de 14+14).
                  final altoDisponible = constraints.maxHeight - 28;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(14),
                    child: ConstrainedBox(
                      // Si el contenido es más corto que la pantalla, lo
                      // obligamos a ocupar como mínimo toda la pantalla
                      // (así el Expanded de abajo puede crecer y no queda
                      // espacio vacío). Si llega a crecer más que la
                      // pantalla, simplemente aparece scroll.
                      constraints: BoxConstraints(minHeight: altoDisponible),
                      child: IntrinsicHeight(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Reportes',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 17,
                                height: 24 / 17,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF092535),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FiltrosReportes(
                              filtrosRapidos: _filtrosRapidos,
                              filtroActivo: _filtroActivo,
                              fechaSeleccionada: _fechaSeleccionada,
                              onSeleccionarRapido: _seleccionarRapido,
                              onElegirFecha: _elegirFecha,
                            ),
                            const SizedBox(height: 17),
                            const TotalVentas(),
                            const SizedBox(height: 12),
                            // Este es el que "absorbe" todo el espacio
                            // sobrante, haciendo que el gráfico crezca en
                            // vez de dejar un hueco vacío debajo.
                            const Expanded(child: IngresosDia()),
                            const SizedBox(height: 12),
                            const DetalleVentas(),
                            const SizedBox(height: 12),
                            const PaginacionReportes(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const cajeroMenu_Widget(currentIndex: 1),
    );
  }
}