import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';

class Compras_Screen extends StatefulWidget {
  const Compras_Screen({super.key});

  @override
  State<Compras_Screen> createState() => _ComprasScreenState();
}

class _ComprasScreenState extends State<Compras_Screen> {

  int _currentIndex = 4; // Mas porque Compras es una subpantalla de ahi

  String _filtroActivo = "Todos";
  final List<String> _filtros = ["Todos", "Proveedor", "Fecha", "Código"];

  final IconData _iconoCompra = Icons.shopping_bag_outlined;
  final Color _iconoColor = const Color(0xFF2E6BF2);
  final Color _iconoBg = const Color(0xFFEAF2FE);

  final List<Map<String, dynamic>> _compras = [
    {
      "numero": "Compra #00125",
      "ref": "Ref: OC-2026-0982",
      "articulos": "Cheesecakes Horneados, Muffins Variados (36 und.)",
      "total": "C\$8,450.00",
    },
    {
      "numero": "Compra #00124",
      "ref": "Ref: OC-2026-0975",
      "articulos": "Croissants Horneados, Empanadas de Piña (40 und.)",
      "total": "C\$4,280.00",
    },
    {
      "numero": "Compra #00123",
      "ref": "Ref: OC-2026-0960",
      "articulos": "Donas Glaseadas, Galletas Chocochip Empacadas (60 und.)",
      "total": "C\$2,150.00",
    },
    {
      "numero": "Compra #00122",
      "ref": "Ref: OC-2026-0948",
      "articulos": "Pasteles Selva Negra, Brownies Gourmet (24 und.)",
      "total": "C\$6,750.00",
    },
    {
      "numero": "Compra #00121",
      "ref": "Ref: OC-2026-0935",
      "articulos": "Postres Tres Leches, Tartaletas de Fruta (30 und.)",
      "total": "C\$5,320.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const TopBar_Widget(), // barra reutilizable

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  GestureDetector(
                    onTap: () => Navigator.pop(context), // regresar Mas_Screen
                    child: Row(
                      children: [
                        const Text("Más Opciones", style: TextStyle(color: Colors.grey, fontSize: 13)),
                        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                        const Text("Compras", style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Text(
                        "Compras",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF1F5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text("68 total", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Consulta de compras realizadas a proveedores.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
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
                        hintText: "Buscar por código, proveedor...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ), // Container buscador

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("HISTORIAL REGISTRADO", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                      Text("Septiembre 2026", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Filtros
                  SizedBox(
                    height: 40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filtros.map((filtro) {
                          bool activo = _filtroActivo == filtro;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _filtroActivo = filtro;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: activo ? const Color(0xFF16233F) : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: activo ? const Color(0xFF16233F) : const Color(0xFFE0E4EA),
                                  ),
                                ),
                                child: Text(
                                  filtro,
                                  style: TextStyle(
                                    color: activo ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ), // filtros

                  const SizedBox(height: 16),

                  // Lista de tarjetas
                  Column(
                    children: _compras.map((compra) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEFF1F5)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _iconoBg,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(_iconoCompra, size: 18, color: _iconoColor),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(compra["numero"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                  Text(compra["ref"], style: const TextStyle(color: Colors.grey, fontSize: 12)),

                                  const SizedBox(height: 8),
                                  const Text("ARTÍCULOS", style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 2),
                                  Text(compra["articulos"], style: const TextStyle(fontSize: 13)),

                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("TOTAL", style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
                                      Text(
                                        compra["total"],
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF16233F)),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 12),

                  // Paginacion
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
            ),

          ],
        ),
      ),
      bottomNavigationBar: menu_Widget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // navegacion cd pantalla
        },
      ),
    );
  }

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