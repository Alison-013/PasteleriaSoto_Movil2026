import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/core/constants/reportes_formato.dart';
import 'package:flutter_pasteleria_26/data/models/purchase_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/purchase_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'widgets/buscador_compras.dart';
import 'widgets/card_compras.dart';
import 'widgets/filtro_dropdown.dart';
import 'widgets/filtros_compras.dart';
import 'widgets/paginacion_compras.dart';
 
class Compras_Screen extends StatefulWidget {
  const Compras_Screen({super.key});
 
  @override
  State<Compras_Screen> createState() => _ComprasScreenState();
}
 
class _ComprasScreenState extends State<Compras_Screen> {
  String _textoBusqueda = "";
  DateTime? _fechaInicio;
  DateTime? _fechaFin;
  String _proveedorSeleccionado = "Todos";
 
  int _paginaActual = 1;
  final int _comprasPorPagina = 5;
 
  // ------------------------------------------------------------
  // FILTRAR COMPRAS
  // ------------------------------------------------------------
 
  List<PurchaseModel> _filtrar(List<PurchaseModel> compras) {
    final busqueda = _textoBusqueda.trim().toLowerCase();
 
    return compras.where((compra) {
      final articulos = compra.details
          .map((d) => d.productName)
          .join(' ')
          .toLowerCase();
 
      // BUSCADOR
      final coincideBusqueda =
          busqueda.isEmpty ||
          "compra #${compra.purchaseId}".toLowerCase().contains(busqueda) ||
          compra.supplierName.toLowerCase().contains(busqueda) ||
          articulos.contains(busqueda);
 
      if (!coincideBusqueda) {
        return false;
      }
 
      // FILTRO POR PROVEEDOR
      if (_proveedorSeleccionado != "Todos" &&
          compra.supplierName != _proveedorSeleccionado) {
        return false;
      }
 
      // FILTRO POR RANGO DE FECHAS
      if (_fechaInicio != null) {
        final desde = DateTime(
            _fechaInicio!.year, _fechaInicio!.month, _fechaInicio!.day);
        if (compra.date.isBefore(desde)) return false;
      }
 
      if (_fechaFin != null) {
        final hasta =
            DateTime(_fechaFin!.year, _fechaFin!.month, _fechaFin!.day)
                .add(const Duration(days: 1));
        if (!compra.date.isBefore(hasta)) return false;
      }
 
      return true;
    }).toList();
  }
 
  // ------------------------------------------------------------
  // TEXTO DE ARTÍCULOS
  // ------------------------------------------------------------
 
  String _textoArticulos(PurchaseModel compra) {
    if (compra.details.isEmpty) return "Sin artículos";
 
    return compra.details
        .map((d) => "${d.productName} (${d.quantity} und.)")
        .join(", ");
  }
 
  // ------------------------------------------------------------
  // SELECCIONAR FECHAS
  // ------------------------------------------------------------
 
  Future<void> _elegirInicio() async {
    final hoy = DateTime.now();
    final ultima = _fechaFin ?? hoy;
 
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaInicio ?? ultima,
      firstDate: DateTime(2023),
      lastDate: ultima,
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
 
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaFin ?? hoy,
      firstDate: primera,
      lastDate: hoy,
    );
 
    if (fecha != null) {
      setState(() {
        _fechaFin = fecha;
        _paginaActual = 1;
      });
    }
  }
 
  // ------------------------------------------------------------
  // LIMPIAR FILTROS
  // ------------------------------------------------------------
 
  void _limpiarFiltros() {
    setState(() {
      _fechaInicio = null;
      _fechaFin = null;
      _proveedorSeleccionado = "Todos";
      _paginaActual = 1;
    });
  }
 
  // ------------------------------------------------------------
  // TEXTO DEL RANGO
  // ------------------------------------------------------------
 
  String get _textoRango {
    if (_fechaInicio == null && _fechaFin == null) return "Todas las fechas";
    if (_fechaInicio != null && _fechaFin == null) {
      return "Desde ${formatearFecha(_fechaInicio!)}";
    }
    if (_fechaInicio == null && _fechaFin != null) {
      return "Hasta ${formatearFecha(_fechaFin!)}";
    }
    return "${formatearFecha(_fechaInicio!)} - ${formatearFecha(_fechaFin!)}";
  }
 
  @override
  Widget build(BuildContext context) {
    final purchases = context.watch<PurchaseProvider>();
    final comprasFiltradas = _filtrar(purchases.purchases);
 
    // Proveedores que existen en las compras (PriceSmart, Del Valle...)
    final proveedores = purchases.purchases
        .map((c) => c.supplierName)
        .toSet()
        .toList()
      ..sort();
    final opcionesProveedor = [
      const FiltroOpcion(label: "Todos"),
      ...proveedores.map((p) => FiltroOpcion(label: p)),
    ];
 
    // TOTAL DE PÁGINAS
    final totalPaginas = comprasFiltradas.isEmpty
        ? 1
        : (comprasFiltradas.length / _comprasPorPagina).ceil();
 
    // Si la página actual ya no existe, volvemos a la última.
    final paginaActual =
        _paginaActual > totalPaginas ? totalPaginas : _paginaActual;
 
    final inicio = (paginaActual - 1) * _comprasPorPagina;
 
    final comprasDeLaPagina =
        comprasFiltradas.skip(inicio).take(_comprasPorPagina).toList();
 
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
 
              const TopBar_Widget(),
 
              Padding(
                padding: const EdgeInsets.all(20),
 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
 
                  children: [
 
                    // RUTA
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
 
                      child: Row(
                        children: const [
                          Text(
                            "Más Opciones",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
 
                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Colors.grey,
                          ),
 
                          Text(
                            "Compras",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
 
                    const SizedBox(height: 8),
 
                    // TITULO
                    Row(
                      children: [
                        const Text(
                          "Compras",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
 
                        const SizedBox(width: 8),
 
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
 
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF1F5),
                            borderRadius: BorderRadius.circular(10),
                          ),
 
                          child: Text(
                            "${comprasFiltradas.length} total",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
 
                    const SizedBox(height: 4),
 
                    const Text(
                      "Consulta de compras realizadas a proveedores.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
 
                    const SizedBox(height: 16),
 
                    // BUSCADOR
                    BuscadorCompras(
                      onChanged: (texto) {
                        setState(() {
                          _textoBusqueda = texto;
                          _paginaActual = 1;
                        });
                      },
                    ),
 
                    const SizedBox(height: 20),
 
                    // ENCABEZADO
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
 
                      children: [
                        const Text(
                          "HISTORIAL REGISTRADO",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
 
                        Text(
                          _textoRango,
 
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
 
                    const SizedBox(height: 12),
 
                    // FILTROS
                    FiltrosCompras(
                      fechaInicio: _fechaInicio,
                      fechaFin: _fechaFin,
                      proveedorSeleccionado: _proveedorSeleccionado,
                      opcionesProveedor: opcionesProveedor,
                      onElegirInicio: _elegirInicio,
                      onElegirFin: _elegirFin,
                      onSeleccionarProveedor: (valor) {
                        setState(() {
                          _proveedorSeleccionado = valor;
                          _paginaActual = 1;
                        });
                      },
                      onLimpiar: _limpiarFiltros,
                    ),
 
                    const SizedBox(height: 16),
 
                    // LISTA DE COMPRAS
                    if (purchases.viewStatus == ViewStatus.loading)
 
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(child: CircularProgressIndicator()),
                      )
 
                    else if (purchases.viewStatus == ViewStatus.error)
 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                purchases.errorMessage ?? "Ocurrió un error.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<PurchaseProvider>()
                                    .fetchPurchases(),
                                child: const Text("Reintentar"),
                              ),
                            ],
                          ),
                        ),
                      )
 
                    else if (comprasDeLaPagina.isEmpty)
 
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
 
                        child: Center(
                          child: Text(
                            "No se encontraron compras.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
 
                    else
 
                      Column(
                        children: comprasDeLaPagina.map((compra) {
                          return TarjetaCompra(
                            numero: "Compra #${compra.purchaseId}",
                            proveedor: compra.supplierName,
                            fecha: formatearFecha(compra.date),
                            articulos: _textoArticulos(compra),
                            total: formatearMonto(compra.totalAmount),
                          );
                        }).toList(),
                      ),
 
                    const SizedBox(height: 12),
 
                    // PAGINACIÓN
                    if (totalPaginas > 1)
                      PaginacionCompras(
                        paginaActual: paginaActual,
                        totalPaginas: totalPaginas,
                        onCambiarPagina: (nueva) =>
                            setState(() => _paginaActual = nueva),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
 
      bottomNavigationBar:
          const menu_Widget(currentIndex: 4),
    );
  }
}
