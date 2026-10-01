import 'package:flutter/material.dart';
import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';

import 'widgets/Card_home.dart';
import 'widgets/encabezado_home.dart';
import 'widgets/grafica_home.dart';
import 'widgets/productos_home.dart';
import 'widgets/ventas_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.05,
                      children: const [
                        TarjetaResumen(
                          icono: Icons.payments_outlined,
                          titulo: 'Ventas',
                          cantidad: r'$27,730.00',
                        ),
                        TarjetaResumen(
                          icono: Icons.shopping_bag_outlined,
                          titulo: 'Pedidos',
                          cantidad: '24',
                        ),
                        TarjetaResumen(
                          icono: Icons.inventory_2_outlined,
                          titulo: 'Stock',
                          cantidad: '79',
                        ),
                        TarjetaResumen(
                          icono: Icons.groups_2_outlined,
                          titulo: 'Clientes',
                          cantidad: '8',
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const EncabezadoSeccion(
                      titulo: 'Ventas de la semana',
                      accion: 'Ver más ›',
                    ),
                    const SizedBox(height: 8),
                    const GraficaSemanal(),
                    const SizedBox(height: 18),
                    const EncabezadoSeccion(
                      titulo: 'Productos más vendidos',
                    ),
                    const SizedBox(height: 8),
                    const ProductoDestacado(
                      nombre: 'Pastel de Trufa',
                      categoria: 'Categoría: Pasteles',
                      unidades: '32',
                      imagenUrl: 'https://picsum.dev/images/ai/food/food-kgdzpabm0g69.jpg',
                      color: Color(0xFFBF8B66),
                    ),
                    const SizedBox(height: 8),
                    const ProductoDestacado(
                      nombre: 'Croissant Clásico',
                      categoria: 'Categoría: Panadería',
                      unidades: '28',
                      imagenUrl: 'https://picsum.dev/images/ai/food/food-9rrtfzhfduh8.jpg',
                      color: Color(0xFFD9A155),
                    ),
                    const SizedBox(height: 18),
                    const EncabezadoSeccion(
                      titulo: 'Ventas recientes',
                    ),
                    const SizedBox(height: 8),
                    const VentaReciente(
                      orden: '#ORD-1042',
                      cliente: 'María González',
                      precio: r'$45.00',
                      estado: 'Completado',
                      colorEstado: Color(0xFFC8EBF4),
                      iconoCliente: Icons.face_3,
                      colorCliente: Color.fromARGB(255, 168, 170, 172),
                    ),
                    const SizedBox(height: 8),
                    const VentaReciente(
                      orden: '#ORD-1041',
                      cliente: 'Carlos Ruiz',
                      precio: r'$120.50',
                      estado: 'Preparando',
                      colorEstado: Color(0xFFDCE9FE),
                      iconoCliente: Icons.face_6,
                      colorCliente: Color.fromARGB(255, 168, 170, 172),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const menu_Widget(currentIndex: 0),
    );
  }
}