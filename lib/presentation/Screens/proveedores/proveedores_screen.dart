import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/supplier_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/supplier_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'widgets/buscador_proveedores.dart';
import 'widgets/card_proveedores.dart';
import 'widgets/detalle_proveedores.dart';
import 'widgets/encabezado_proveedores.dart';
import 'widgets/filtros_proveedores.dart';
import 'widgets/Paginacion_proveedores.dart';

class Proveedores extends StatefulWidget {
  const Proveedores({super.key});

  @override
  State<Proveedores> createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
  int _filtroActivo = 0;
  int _paginaActual = 1;

  final int _proveedoresPorPagina = 5;

  String _textoBusqueda = '';

  final List<String> _filtros = const [
    'Todos',
    'Activos',
    'Inactivos',
  ];

  List<SupplierModel> _filtrar(List<SupplierModel> proveedores) {
    List<SupplierModel> resultado = proveedores;

    // Filtro por estado
    if (_filtroActivo == 1) {
      resultado = resultado
          .where((proveedor) => proveedor.isActive)
          .toList();
    } else if (_filtroActivo == 2) {
      resultado = resultado
          .where((proveedor) => !proveedor.isActive)
          .toList();
    }

    // Búsqueda
    if (_textoBusqueda.trim().isNotEmpty) {
      final texto = _textoBusqueda.toLowerCase().trim();

      resultado = resultado.where((proveedor) {
        return proveedor.supplierName.toLowerCase().contains(texto) ||
            proveedor.codigo.toLowerCase().contains(texto) ||
            proveedor.detalle.toLowerCase().contains(texto);
      }).toList();
    }

    return resultado;
  }

  int _totalPaginas(List<SupplierModel> filtrados) {
    if (filtrados.isEmpty) {
      return 1;
    }

    return (filtrados.length / _proveedoresPorPagina).ceil();
  }

  List<SupplierModel> _paginaDe(List<SupplierModel> filtrados, int pagina) {
    final inicio = (pagina - 1) * _proveedoresPorPagina;

    return filtrados.skip(inicio).take(_proveedoresPorPagina).toList();
  }

  void _cambiarFiltro(int indice) {
    setState(() {
      _filtroActivo = indice;
      _paginaActual = 1;
    });
  }

  void _cambiarPagina(int pagina) {
    setState(() {
      _paginaActual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    final suppliers = context.watch<SupplierProvider>();
    final filtrados = _filtrar(suppliers.suppliers);
    final totalPaginas = _totalPaginas(filtrados);
    final paginaActual = _paginaActual > totalPaginas ? totalPaginas : _paginaActual;
    final proveedores = _paginaDe(filtrados, paginaActual);

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

                    EncabezadoProveedores(total: filtrados.length),

                    const SizedBox(height: 16),

                    // BUSCADOR
                    BuscadorProveedores(
                      onChanged: (texto) {
                        setState(() {
                          _textoBusqueda = texto;
                          _paginaActual = 1;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // ENCABEZADO
                    const Text(
                      "DIRECTORIO REGISTRADO",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // FILTROS
                    FiltrosProveedores(
                      filtros: _filtros,
                      filtroActivo: _filtroActivo,
                      onSeleccionar: _cambiarFiltro,
                    ),

                    const SizedBox(height: 16),

                    // LISTA DE PROVEEDORES
                    if (suppliers.viewStatus == ViewStatus.loading)

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(child: CircularProgressIndicator()),
                      )

                    else if (suppliers.viewStatus == ViewStatus.error)

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                suppliers.errorMessage ?? "Ocurrió un error.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<SupplierProvider>()
                                    .fetchSuppliers(),
                                child: const Text("Reintentar"),
                              ),
                            ],
                          ),
                        ),
                      )

                    else if (proveedores.isEmpty)

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),

                        child: Center(
                          child: Text(
                            "No se encontraron proveedores.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )

                    else

                      Column(
                        children: proveedores.map((proveedor) {
                          return CardProveedor(
                            proveedor: proveedor,
                            onTap: () => mostrarDetalleProveedor(context, proveedor),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 12),

                    // PAGINACIÓN
                    if (totalPaginas > 1)
                      PaginacionProveedores(
                        paginaActual: paginaActual,
                        totalPaginas: totalPaginas,
                        onPaginaSeleccionada: _cambiarPagina,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const menu_Widget(currentIndex: 4),
    );
  }
}