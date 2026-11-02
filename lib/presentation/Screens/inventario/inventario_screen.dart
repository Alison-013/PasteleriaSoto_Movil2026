import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/inventory_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/inventory_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'package:provider/provider.dart';
import 'widgets/producto_card_widget.dart';
import 'widgets/filtro_dropdown_widget.dart';
import 'widgets/paginacion_widget.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _busqueda = "";
  String _categoriaSeleccionada = "Todos";
  String _stockSeleccionado = "Todos";
  int _paginaActual = 1;
  static const int _itemsPorPagina = 5;


  // Opciones del filtro de Stock
  final List<FiltroOpcion> _opcionesStock = const [
    FiltroOpcion(label: "Todos"),
    FiltroOpcion(label: "Disponible", color: Color(0xFF27AE60)),
    FiltroOpcion(label: "Bajo stock", color: Color(0xFFF2994A)),
    FiltroOpcion(label: "Agotado", color: Color(0xFFEB5757)),
  ];

  // Aplica buscador + stock
  List<InventoryModel> _filtrar(List<InventoryModel> productos) {
    return productos.where((p) {
      final coincideBusqueda = _busqueda.isEmpty ||
          p.productName.toLowerCase().contains(_busqueda.toLowerCase()) ||
          p.productId.toString().contains(_busqueda) ||
          p.description.toLowerCase().contains(_busqueda.toLowerCase()) ||
          p.categoryName.toLowerCase().contains(_busqueda.toLowerCase());
 
      final coincideCategoria =
          _categoriaSeleccionada == "Todos" || p.categoryName == _categoriaSeleccionada;
 
      final coincideStock =
          _stockSeleccionado == "Todos" || p.estado == _stockSeleccionado;
 
      return coincideBusqueda && coincideCategoria && coincideStock;
    }).toList();
  }
 

  void _actualizarBusqueda(String valor) {
    setState(() {
      _busqueda = valor;
      _paginaActual = 1;
    });
  }

  void _actualizarCategoria(String valor) {
    setState(() {
      _categoriaSeleccionada = valor;
      _paginaActual = 1;
    });
  }

  void _actualizarStock(String valor) {
    setState(() {
      _stockSeleccionado = valor;
      _paginaActual = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inventario = context.watch<InventoryProvider>();
    final productosFiltrados = _filtrar(inventario.items);
    final categorias = inventario.items.map((p) => p.categoryName).toSet().toList()..sort();
    final opcionesCategoria = [
    const FiltroOpcion(label: "Todos"),
     ...categorias.map((c) => FiltroOpcion(label: c)),
    ];

    // Cálculo de paginación sobre la lista ya filtrada.
    final totalPaginas = productosFiltrados.isEmpty
        ? 1
        : (productosFiltrados.length / _itemsPorPagina).ceil();
    final paginaActual = _paginaActual > totalPaginas ? totalPaginas : _paginaActual;
    final inicio = (paginaActual - 1) * _itemsPorPagina;
    final fin = (inicio + _itemsPorPagina) > productosFiltrados.length
        ? productosFiltrados.length
        : inicio + _itemsPorPagina;
    final productosPagina = productosFiltrados.sublist(inicio, fin);

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
                    // ==================================================
                    // TITULO
                    // ==================================================

                    Text(
                      "Inventario",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==================================================
                    // BUSCADOR
                    // ==================================================

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE0E4EA)),
                      ),
                      child: TextField(
                        onChanged: _actualizarBusqueda,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.search, color: Colors.grey),
                          hintText: "Buscar por nombre, SKU...",
                          hintStyle: GoogleFonts.playfairDisplay(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ==================================================
                    // FILTROS
                    // ==================================================

                    Row(
                      children: [
                        FiltroDropdownWidget(
                          titulo: "Categoría",
                          opciones: opcionesCategoria,
                          seleccionado: _categoriaSeleccionada,
                          onSeleccionar: _actualizarCategoria,
                        ),

                        const SizedBox(width: 10),

                        FiltroDropdownWidget(
                          titulo: "Stock",
                          opciones: _opcionesStock,
                          seleccionado: _stockSeleccionado,
                          onSeleccionar: _actualizarStock,
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // ==================================================
                    // PRODUCTOS
                    // ==================================================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Productos",
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 8),

                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF1F5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${productosFiltrados.length} total",
                                style: GoogleFonts.playfairDisplay(fontSize: 12),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Icon(Icons.swap_vert, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              "Ordenar: Stock",
                              style: GoogleFonts.playfairDisplay(color: Colors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // ==================================================
                    // LISTA DE PRODUCTOS (solo los de la página actual)
                    // ==================================================

                        if (inventario.viewStatus == ViewStatus.loading)
                         const Padding(
                         padding: EdgeInsets.symmetric(vertical: 24),
                         child: Center(child: CircularProgressIndicator()),
                        )
                        else if (inventario.viewStatus == ViewStatus.error)
                         Padding(
                         padding: const EdgeInsets.symmetric(vertical: 24),
                         child: Center(
                           child: Column(
                             children: [
                              Text(
                                inventario.errorMessage ?? "Ocurrió un error.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.playfairDisplay(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => context.read<InventoryProvider>().fetchInventory(),
                                child: const Text("Reintentar"),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Column(
                        children: productosPagina.map((producto) {
                          return ProductoCardWidget(
                            nombre: producto.productName,
                            categoria: producto.categoryName,
                            sku: producto.productId.toString(),
                            uds: producto.quantity,
                            estado: producto.estado,
                            imagenUrl: producto.imagen,
                          );
                        }).toList(),
                      ),
 
                    // ==================================================
                    // SIN PRODUCTOS
                    // ==================================================
                    
                    if (inventario.viewStatus == ViewStatus.success && productosFiltrados.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            "No se encontraron productos con esos filtros.",
                            style: GoogleFonts.playfairDisplay(color: Colors.grey),
                          ),
                        ),
                    ),
 
                    const SizedBox(height: 12),
 

                    // ==================================================
                    // PAGINACIÓN (funcional)
                    // ==================================================

                    PaginacionWidget(
                      paginaActual: paginaActual,
                      totalPaginas: totalPaginas,
                      onCambiarPagina: (nuevaPagina) => setState(() => _paginaActual = nuevaPagina),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const menu_Widget(currentIndex: 1),
    );
  }
}