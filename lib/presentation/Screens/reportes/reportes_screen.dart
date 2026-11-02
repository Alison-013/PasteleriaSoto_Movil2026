// Ubicación: lib/presentation/Screens/reportes/reportes_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/core/constants/reportes_formato.dart';
import 'package:flutter_pasteleria_26/data/models/sale_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/sale_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';

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
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  int _paginaActual = 1;
  static const int _itemsPorPagina = 4;

  Future<DateTime?> _abrirCalendario({
    required DateTime inicial,
    required DateTime primera,
    required DateTime ultima,
  }) {
    return showDatePicker(
      context: context,
      initialDate: inicial,
      firstDate: primera,
      lastDate: ultima,
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
  }

  Future<void> _elegirInicio() async {
    final hoy = DateTime.now();
    final ultima = _fechaFin ?? hoy;
    final fecha = await _abrirCalendario(
      inicial: _fechaInicio ?? ultima,
      primera: DateTime(2023),
      ultima: ultima,
    );

    if (fecha != null) {
      setState(() {
        _fechaInicio = fecha;
        _paginaActual = 1;
      });
    }
  }

  Future<void> _elegirFin() async {
    final hoy = DateTime.now();
    final primera = _fechaInicio ?? DateTime(2023);
    final fecha = await _abrirCalendario(
      inicial: _fechaFin ?? hoy,
      primera: primera,
      ultima: hoy,
    );

    if (fecha != null) {
      setState(() {
        _fechaFin = fecha;
        _paginaActual = 1;
      });
    }
  }

  void _limpiarFechas() {
    setState(() {
      _fechaInicio = null;
      _fechaFin = null;
      _paginaActual = 1;
    });
  }

  List<SaleModel> _filtrar(List<SaleModel> ventas) {
    return ventas.where((v) {
      if (_fechaInicio != null) {
        final desde = DateTime(_fechaInicio!.year, _fechaInicio!.month, _fechaInicio!.day);
        if (v.saleDate.isBefore(desde)) return false;
      }
      if (_fechaFin != null) {
        final hasta = DateTime(_fechaFin!.year, _fechaFin!.month, _fechaFin!.day)
            .add(const Duration(days: 1));
        if (!v.saleDate.isBefore(hasta)) return false;
      }
      return true;
    }).toList();
  }

  String get _textoRango {
    if (_fechaInicio == null && _fechaFin == null) return 'Todas las fechas';
    if (_fechaInicio != null && _fechaFin == null) {
      return 'Desde ${formatearFecha(_fechaInicio!)}';
    }
    if (_fechaInicio == null && _fechaFin != null) {
      return 'Hasta ${formatearFecha(_fechaFin!)}';
    }
    return '${formatearFecha(_fechaInicio!)} - ${formatearFecha(_fechaFin!)}';
  }

  ({List<String> etiquetas, List<double> valores}) _datosGrafico(List<SaleModel> ventas) {
    final Map<DateTime, double> porDia = {};
    for (final v in ventas) {
      final dia = DateTime(v.saleDate.year, v.saleDate.month, v.saleDate.day);
      porDia[dia] = (porDia[dia] ?? 0) + v.saleTotal;
    }

    final dias = porDia.keys.toList()..sort();
    final ultimos = dias.length > 6 ? dias.sublist(dias.length - 6) : dias;

    return (
      etiquetas: ultimos
          .map((d) =>
              '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}')
          .toList(),
      valores: ultimos.map((d) => porDia[d]!).toList(),
    );
  }

  List<LineaDetalle> _lineasDetalle(List<SaleModel> ventas) {
    final Map<String, double> monto = {};
    final Map<String, Set<int>> ventasPorProducto = {};
    double otrosMonto = 0;
    int otrosVentas = 0;

    for (final v in ventas) {
      double sumaLineas = 0;
      for (final d in v.details) {
        monto[d.productName] = (monto[d.productName] ?? 0) + d.lineAmount;
        (ventasPorProducto[d.productName] ??= <int>{}).add(v.saleId);
        sumaLineas += d.lineAmount;
      }

      
      final diferencia = v.saleTotal - sumaLineas;
      if (diferencia > 0.009) {
        otrosMonto += diferencia;
        otrosVentas++;
      }
    }

    final lineas = monto.entries
        .map((e) => LineaDetalle(
              producto: e.key,
              ordenes: ventasPorProducto[e.key]!.length,
              monto: e.value,
            ))
        .toList()
      ..sort((a, b) => b.monto.compareTo(a.monto));

    if (otrosVentas > 0) {
      lineas.add(LineaDetalle(
        producto: 'Personalizados y otros',
        ordenes: otrosVentas,
        monto: otrosMonto,
      ));
    }

    return lineas;
  }

  @override
  Widget build(BuildContext context) {
    final sales = context.watch<SaleProvider>();
    final ventas = _filtrar(sales.sales);

    final total = ventas.fold<double>(0, (suma, v) => suma + v.saleTotal);
    final grafico = _datosGrafico(ventas);
    final lineas = _lineasDetalle(ventas);

    // Paginación del detalle.
    final totalPaginas =
        lineas.isEmpty ? 1 : (lineas.length / _itemsPorPagina).ceil();
    final paginaActual = _paginaActual > totalPaginas ? totalPaginas : _paginaActual;
    final inicio = (paginaActual - 1) * _itemsPorPagina;
    final fin = (inicio + _itemsPorPagina) > lineas.length
        ? lineas.length
        : inicio + _itemsPorPagina;
    final lineasPagina = lineas.sublist(inicio, fin);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final altoDisponible = constraints.maxHeight - 28;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(14),
                    child: ConstrainedBox(
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
                              fechaInicio: _fechaInicio,
                              fechaFin: _fechaFin,
                              onElegirInicio: _elegirInicio,
                              onElegirFin: _elegirFin,
                              onLimpiar: _limpiarFechas,
                            ),
                            const SizedBox(height: 17),

                            if (sales.viewStatus == ViewStatus.loading)
                              const Expanded(
                                child: Center(child: CircularProgressIndicator()),
                              )
                            else if (sales.viewStatus == ViewStatus.error)
                              Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        sales.errorMessage ?? 'Ocurrió un error.',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(color: Colors.red),
                                      ),
                                      const SizedBox(height: 8),
                                      ElevatedButton(
                                        onPressed: () =>
                                            context.read<SaleProvider>().fetchSales(),
                                        child: const Text('Reintentar'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else ...[
                              TotalVentas(total: total),
                              const SizedBox(height: 12),
                              Expanded(
                                child: IngresosDia(
                                  etiquetas: grafico.etiquetas,
                                  valores: grafico.valores,
                                ),
                              ),
                              const SizedBox(height: 12),
                              DetalleVentas(rango: _textoRango, lineas: lineasPagina),
                              const SizedBox(height: 12),
                              PaginacionReportes(
                                paginaActual: paginaActual,
                                totalPaginas: totalPaginas,
                                onCambiarPagina: (nueva) =>
                                    setState(() => _paginaActual = nueva),
                              ),
                            ],
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
      bottomNavigationBar: const menu_Widget(currentIndex: 2),
    );
  }
}