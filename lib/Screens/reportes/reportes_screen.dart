import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';

import 'widgets/detalle_reportes.dart';
import 'widgets/filtros_reportes.dart';
import 'widgets/ingresos_reportes.dart';
import 'widgets/paginacion_reportes.dart';
import 'widgets/total_reportes.dart';

class reportes extends StatefulWidget {
  const reportes({super.key});

  @override
  State<reportes> createState() => _ReportesState();
}

class _ReportesState extends State<reportes> {
  int _filtroActivo = 0;

  final List<String> _filtros = const [
    'Por Día',
    'Semanal',
    'Por Mes',
    'Anual',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      filtros: _filtros,
                      filtroActivo: _filtroActivo,
                      onSeleccionar: (indice) {
                        setState(() {
                          _filtroActivo = indice;
                        });
                      },
                    ),
                    const SizedBox(height: 17),
                    const TotalVentas(),
                    const SizedBox(height: 12),
                    const IngresosDia(),
                    const SizedBox(height: 12),
                    const DetalleVentas(),
                    const SizedBox(height: 12),
                    const PaginacionReportes(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const menu_Widget(currentIndex: 2),
    );
  }
}