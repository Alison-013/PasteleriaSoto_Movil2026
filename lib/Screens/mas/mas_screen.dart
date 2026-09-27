import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';

class Mas_Screen extends StatefulWidget {
  const Mas_Screen({super.key});

  @override
  State<Mas_Screen> createState() => _MasScreenState();
}

class _MasScreenState extends State<Mas_Screen> {

  final List<Map<String, dynamic>> _opciones = [
    {
      "icono": Icons.people_outline,
      "titulo": "Clientes",
      "descripcion": "Directorio, historial y gestión de clientes.",
      "ruta": null, // todavia no existe esta pantalla
    },
    {
      "icono": Icons.shopping_cart_outlined,
      "titulo": "Compras",
      "descripcion": "Gestión de órdenes de compra y facturación.",
      "ruta": AppRoutes.compras,
    },
    {
      "icono": Icons.local_shipping_outlined,
      "titulo": "Proveedores",
      "descripcion": "Directorio y evaluación de proveedores de materia prima.",
      "ruta":  AppRoutes.proveedores, 
    },
    {
      "icono": Icons.shield_outlined,
      "titulo": "Seguridad",
      "descripcion": "Gestión de usuarios, roles y permisos de acceso.",
      "ruta": AppRoutes.seguridad,
    },
    {
      "icono": Icons.settings_outlined,
      "titulo": "Configuración",
      "descripcion": "Ajustes generales del sistema, notificaciones y perfil de empresa.",
      "ruta": null, // todavia no existe esta pantalla
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

            const TopBar_Widget(), // barra de arriba reutilizable

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

                  // Lista de tarjetas de opciones
                  Column(
                    children: _opciones.map((opcion) {
                      return GestureDetector(
                        onTap: () {
                          if (opcion["ruta"] != null) {
                            Navigator.pushNamed(context, opcion["ruta"]);
                          }
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
                              ),

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
      bottomNavigationBar: const menu_Widget(currentIndex: 4), // 4 = Más
    );
  }
}