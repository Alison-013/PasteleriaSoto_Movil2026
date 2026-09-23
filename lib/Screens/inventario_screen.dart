import 'package:flutter/material.dart';
import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';
 
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});
 
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}
 
 class _InventoryScreenState extends State<InventoryScreen> {
    int _currentIndex = 1; // "Inventario" es el tab activo cuando le demos click
    
    // Filtro seleccionado actualmente es todo osea que saldra en un color oscuro
    String _filtroActivo = "Todos";

    // Lista de filtros. Los de categoria usan el color oscuro,
    // los de estado (Bajo stock, Disponible, Agotado) usan su propio color.
    final List<Map<String, dynamic>> _filtros = [
      {"label": "Todos", "color": const Color(0xFF16233F)},
      {"label": "Repostería", "color": const Color(0xFF16233F)},
      {"label": "Panadería", "color": const Color(0xFF16233F)},
      {"label": "Tartaletas", "color": const Color(0xFF16233F)},
      {"label": "Bajo stock", "color": const Color(0xFFF2994A)},
      {"label": "Disponible", "color": const Color(0xFF27AE60)},
      {"label": "Agotado", "color": const Color(0xFFEB5757)},
    ];

    //estos los agg yo pq solo es prototipo nada del backend asi que mejor tenerlos con datos de prueba 
    final List<Map<String, dynamic>> _productos = [
    {"nombre": "Pastel de Chocolate M", "categoria": "Pastelería", "sku": "PST-CHO-01", "uds": 24, "estado": "Disponible"},
    {"nombre": "Croissant Clásico", "categoria": "Panadería", "sku": "PAN-CRO-01", "uds": 4, "estado": "Bajo stock"},
    {"nombre": "Tartaleta de Frutas", "categoria": "Tartaletas", "sku": "TAR-FRU-003", "uds": 0, "estado": "Agotado"},
    {"nombre": "Pan Campesino", "categoria": "Panadería", "sku": "PAN-CAM-01", "uds": 12, "estado": "Disponible"},
    {"nombre": "Cheesecake de Fresa", "categoria": "Pastelería", "sku": "PST-CHS-01", "uds": 18, "estado": "Disponible"},
    {"nombre": "Muffin de Arándanos", "categoria": "Panadería", "sku": "PAN-MUF-01", "uds": 6, "estado": "Bajo stock"},
    {"nombre": "Tres Leches Clásico", "categoria": "Pastelería", "sku": "PST-TRL-01", "uds": 15, "estado": "Disponible"},
  ];
  // agg esto para que tengan color el fondo de los estados en las tarjetas
  Color _colorEstado(String estado) {
    if (estado == "Disponible") return const Color(0xFF27AE60);
    if (estado == "Bajo stock") return const Color(0xFFF2994A);
    return const Color(0xFFEB5757); // Agotado
  }
 

   @override
   Widget build(BuildContext context) {
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
 
                  // Buscador
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E4EA)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Buscar por nombre, SKU...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ), // Container buscador
 
                  const SizedBox(height: 16),
 
                  // Filtros con scroll horizontal
                  SizedBox(
                    height: 40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filtros.map((filtro) {
                          bool activo = _filtroActivo == filtro["label"];
                          Color color = filtro["color"];
 
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _filtroActivo = filtro["label"];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: activo ? color : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: activo ? color : const Color(0xFFE0E4EA),
                                  ),
                                ),
                                child: Text(
                                  filtro["label"],
                                  style: TextStyle(
                                    color: activo
                                        ? Colors.white
                                        : (color == const Color(0xFF16233F) ? Colors.black87 : color),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ), // Container chip
                            ), // GestureDetector
                          ); // Padding
                        }).toList(),
                      ), // Row
                    ), // SingleChildScrollView
                  ), // SizedBox filtros
 
                  const SizedBox(height: 20),
 
                  // Encabezado de la lista: "Productos  142 total" + "Ordenar: Stock"
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
                            child: const Text("142 total", style: TextStyle(fontSize: 12)),
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
                  ), // Row encabezado
 
                  const SizedBox(height: 12),
 
                  // Lista de tarjetas de producto
                  Column(
                    children: _productos.map((producto) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEFF1F5)),
                        ),
                        child: Row(
                          children: [
                            // Imagen (placeholder, luego se cambia por la foto real hasta que investigue)
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F6F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.cake_outlined, color: Colors.grey),
                            ),
 
                            const SizedBox(width: 12),
 
                            // Nombre + categoria
                            //expanded lo utilizo para El lugar q sobre
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    producto["nombre"],
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${producto["categoria"]} • SKU: ${producto["sku"]}",
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ), // Expanded
 
                            // Unidades + estado
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${producto["uds"]} uds",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _colorEstado(producto["estado"]),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: _colorEstado(producto["estado"]).withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    producto["estado"],
                                    style: TextStyle(
                                      color: _colorEstado(producto["estado"]),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
 
                          ],
                        ), // Row tarjeta
                      ); // Container tarjeta
                    }).toList(),
                  ), // Column lista de productos
 
                  const SizedBox(height: 12),
 
                  // Paginacion (por ahora solo visual)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Página 1 de 3", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 12),
                      const Icon(Icons.chevron_left, color: Colors.grey),
                      const SizedBox(width: 8),
                      _numeroPagina(1, activo: true),
                      const SizedBox(width: 8),
                      _numeroPagina(2, activo: false),
                      const SizedBox(width: 8),
                      _numeroPagina(3, activo: false),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
 
                ],
              ),
            ), // Padding contenido
 
          ],
        ), // Column general
      ), // SingleChildScrollView

      bottomNavigationBar: menu_Widget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // aqui despues iria la navegacion a cada pantalla pero mi compañera no tiene aun las de ella
        },
      ), // BottomNavWidget
    );
  }
 
  // Circulo numerado para la paginacion
  Widget _numeroPagina(int numero, {required bool activo}) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF16233F) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE0E4EA)),
      ),
      child: Text(
        "$numero",
        style: TextStyle(color: activo ? Colors.white : Colors.black87),
      ),
    );
  }
     
}
      