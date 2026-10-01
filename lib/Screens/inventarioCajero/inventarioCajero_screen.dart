import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/Widgets/cajeroMenu_widget.dart';
import '/Widgets/TopBar_Cajero.dart';
import 'widgets/producto_card_widget.dart';
import 'widgets/filtro_dropdown_widget.dart';
import 'widgets/paginacion_widget.dart';

class InventoryCajeroScreen extends StatefulWidget {
  const InventoryCajeroScreen({super.key});

  @override
  State<InventoryCajeroScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryCajeroScreen> {
  String _busqueda = "";
  String _categoriaSeleccionada = "Todos";
  String _stockSeleccionado = "Todos";
  int _paginaActual = 1;
  static const int _itemsPorPagina = 5;

  // Opciones del filtro de Categoría
  final List<FiltroOpcion> _opcionesCategoria = const [
    FiltroOpcion(label: "Todos"),
    FiltroOpcion(label: "Pastelería"),
    FiltroOpcion(label: "Panadería"),
    FiltroOpcion(label: "Tartaletas"),
  ];

  // Opciones del filtro de Stock
  final List<FiltroOpcion> _opcionesStock = const [
    FiltroOpcion(label: "Todos"),
    FiltroOpcion(label: "Disponible", color: Color(0xFF27AE60)),
    FiltroOpcion(label: "Bajo stock", color: Color(0xFFF2994A)),
    FiltroOpcion(label: "Agotado", color: Color(0xFFEB5757)),
  ];

  // Lista de productos con datos de prueba.
  final List<Map<String, dynamic>> _productos = [
    {
      "nombre": "Pastel de Chocolate M",
      "categoria": "Pastelería",
      "sku": "PST-CHO-01",
      "uds": 24,
      "estado": "Disponible",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-uibpackxl0dl.jpg",
    },
    {
      "nombre": "Croissant Clásico",
      "categoria": "Panadería",
      "sku": "PAN-CRO-01",
      "uds": 4,
      "estado": "Bajo stock",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-gu4gq8otdsxz.jpg",
    },
    {
      "nombre": "Tartaleta de Frutas",
      "categoria": "Tartaletas",
      "sku": "TAR-FRU-003",
      "uds": 0,
      "estado": "Agotado",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-kqpvjmi0a9tf.jpg",
    },
    {
      "nombre": "Pan Campesino",
      "categoria": "Panadería",
      "sku": "PAN-CAM-01",
      "uds": 12,
      "estado": "Disponible",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-lo9lwvzbbevj.jpg",
    },
    {
      "nombre": "Cheesecake de Fresa",
      "categoria": "Pastelería",
      "sku": "PST-CHS-01",
      "uds": 18,
      "estado": "Disponible",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-8elsmfgudawe.jpg",
    },
    {
      "nombre": "Muffin de Arándanos",
      "categoria": "Panadería",
      "sku": "PAN-MUF-01",
      "uds": 6,
      "estado": "Bajo stock",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-zm302zzpbwrf.jpg",
    },
    {
      "nombre": "Tres Leches Clásico",
      "categoria": "Pastelería",
      "sku": "PST-TRL-01",
      "uds": 15,
      "estado": "Disponible",
      "imagenUrl": "https://picsum.dev/images/ai/food/food-muaie69g5o9w.jpg",
    },
  ];

  // Aplica buscador + los dos filtros (Categoría y Stock) combinados.
  List<Map<String, dynamic>> get _productosFiltrados {
    return _productos.where((p) {
      final coincideBusqueda = _busqueda.isEmpty ||
          p["nombre"].toString().toLowerCase().contains(_busqueda.toLowerCase()) ||
          p["sku"].toString().toLowerCase().contains(_busqueda.toLowerCase());

      final coincideCategoria =
          _categoriaSeleccionada == "Todos" || p["categoria"] == _categoriaSeleccionada;

      final coincideStock =
          _stockSeleccionado == "Todos" || p["estado"] == _stockSeleccionado;

      return coincideBusqueda && coincideCategoria && coincideStock;
    }).toList();
  }

  // Cada vez que cambian búsqueda o filtros, se vuelve a la página 1
  // para evitar quedar en una página que ya no existe.
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
    final productosFiltrados = _productosFiltrados;

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
              const TopBar_Cajero(),

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
                          opciones: _opcionesCategoria,
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

                    Column(
                      children: productosPagina.map((producto) {
                        return ProductoCardWidget(
                          nombre: producto["nombre"],
                          categoria: producto["categoria"],
                          sku: producto["sku"],
                          uds: producto["uds"],
                          estado: producto["estado"],
                          imagenUrl: producto["imagenUrl"],
                        );
                      }).toList(),
                    ),

                    // ==================================================
                    // SIN PRODUCTOS
                    // ==================================================

                    if (productosFiltrados.isEmpty)
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

      bottomNavigationBar: const cajeroMenu_Widget(currentIndex: 0),
    );
  }
}