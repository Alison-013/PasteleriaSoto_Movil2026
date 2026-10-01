import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';
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
  // "imagenUrl" es un placeholder de prueba (picsum.photos con seed fijo);
  // cuando tengan fotos reales, solo se reemplaza por esa URL o asset.
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

  @override
  Widget build(BuildContext context) {
    final productosFiltrados = _productosFiltrados;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopBar_Widget(), // barra de arriba reutilizable

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Inventario",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // Buscador general por nombre o SKU
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E4EA)),
                    ),
                    child: TextField(
                      onChanged: (valor) => setState(() => _busqueda = valor),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Buscar por nombre, SKU...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Filtros: Categoría y Stock (cada uno desplegable, con buscador propio)
                  Row(
                    children: [
                      FiltroDropdownWidget(
                        titulo: "Categoría",
                        opciones: _opcionesCategoria,
                        seleccionado: _categoriaSeleccionada,
                        onSeleccionar: (valor) => setState(() => _categoriaSeleccionada = valor),
                      ),
                      const SizedBox(width: 10),
                      FiltroDropdownWidget(
                        titulo: "Stock",
                        opciones: _opcionesStock,
                        seleccionado: _stockSeleccionado,
                        onSeleccionar: (valor) => setState(() => _stockSeleccionado = valor),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Productos",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.swap_vert, size: 16, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("Ordenar: Stock", style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Lista de tarjetas de producto (widget ProductoCardWidget)
                  Column(
                    children: productosFiltrados.map((producto) {
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

                  if (productosFiltrados.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          "No se encontraron productos con esos filtros.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  const PaginacionWidget(paginaActual: 1, totalPaginas: 3),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const menu_Widget(currentIndex: 1), // 1 = Inventario
    );
  }
}