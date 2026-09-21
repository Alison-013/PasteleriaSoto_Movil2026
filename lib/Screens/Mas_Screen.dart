import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';


class Mas_Screen extends StatefulWidget {
  const Mas_Screen({super.key});

  @override
  State<Mas_Screen> createState() => _MasScreenState();
}

class _MasScreenState extends State<Mas_Screen> {

  int _currentIndex = 4; // mas es el tab activo

  //lista de las opcione 
  final List<Map<String, dynamic>> _opciones = [
    {
      "icono": Icons.people_outline,
      "titulo": "Clientes",
      "descripcion": "Directorio, historial y gestión de clientes.",
    },
    {
      "icono": Icons.shopping_cart_outlined,
      "titulo": "Compras",
      "descripcion": "Gestión de órdenes de compra y facturación.",
    },
    {
      "icono": Icons.local_shipping_outlined,
      "titulo": "Proveedores",
      "descripcion": "Directorio y evaluación de proveedores de materia prima.",
    },
    {
      "icono": Icons.shield_outlined,
      "titulo": "Seguridad",
      "descripcion": "Gestión de usuarios, roles y permisos de acceso.",
    },
    {
      "icono": Icons.settings_outlined,
      "titulo": "Configuración",
      "descripcion": "Ajustes generales del sistema, notificaciones y perfil de empresa.",
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

            const TopBar_Widget(), //reutilizable 
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Más Opciones",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Gestión avanzada y configuración del sistema.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),

                  const SizedBox(height: 20),

                  // Lista de tarjetas en opciones
                  Column(
                    children: _opciones.map((opcion) {
                      return GestureDetector(
                        onTap: () {
                          // navegacion de cd opcion 
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFEFF1F5)),
                          ),
                          child: Row(
                            children: [

                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF4F6F9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(opcion["icono"], color: const Color(0xFF16233F)),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      opcion["titulo"],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      opcion["descripcion"],
                                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ), // Expanded

                              const Icon(Icons.chevron_right, color: Colors.grey),

                            ],
                          ),
                        ),
                      );
                    }).toList(),
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
         //navegacion a cd pantalla
        },
      ),
    );
  }
}