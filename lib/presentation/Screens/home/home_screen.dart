import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/core/constants/reportes_formato.dart';
import 'package:flutter_pasteleria_26/data/models/inventory_model.dart';
import 'package:flutter_pasteleria_26/data/models/sale_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/inventory_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/sale_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'widgets/Card_home.dart';
import 'widgets/encabezado_home.dart';
import 'widgets/grafica_home.dart';
import 'widgets/productos_home.dart';
import 'widgets/ventas_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  // para mirar ventas de la semana
  List<double> _ventasSemana(List<SaleModel> ventas) {
    final hoy = DateTime.now();
    final lunes = DateTime(hoy.year, hoy.month, hoy.day)
        .subtract(Duration(days: hoy.weekday - 1));
    final valores = List<double>.filled(7, 0);

    for (final v in ventas) {
      final dia = DateTime(v.saleDate.year, v.saleDate.month, v.saleDate.day);
      final indice = dia.difference(lunes).inDays;
      if (indice >= 0 && indice < 7) {
        valores[indice] += v.saleTotal;
      }
    }
    return valores;
  }

  // para los 2 productos con más unidades vendidas.
  List<MapEntry<String, int>> _masVendidos(List<SaleModel> ventas) {
    final Map<String, int> unidades = {};
    for (final v in ventas) {
      for (final d in v.details) {
        unidades[d.productName] = (unidades[d.productName] ?? 0) + d.quantity;
      }
    }
    final lista = unidades.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return lista.take(2).toList();
  }

  // para las 2 ventas más recientes.
  List<SaleModel> _recientes(List<SaleModel> ventas) {
    final lista = List<SaleModel>.from(ventas)
      ..sort((a, b) => b.saleDate.compareTo(a.saleDate));
    return lista.take(2).toList();
  }

  @override
  Widget build(BuildContext context) {
    final sales = context.watch<SaleProvider>();
    final inventory = context.watch<InventoryProvider>();

    final cargando = sales.viewStatus == ViewStatus.loading ||
        inventory.viewStatus == ViewStatus.loading;
    final conError = sales.viewStatus == ViewStatus.error ||
        inventory.viewStatus == ViewStatus.error;

    final ventas = sales.sales;
    final total = ventas.fold<double>(0, (suma, v) => suma + v.saleTotal);
    final pedidos = ventas.length;
    final stock = inventory.items.fold<int>(0, (suma, i) => suma + i.quantity);
    final clientes = ventas.map((v) => v.customerId).toSet().length;

    final masVendidos = _masVendidos(ventas);
    final recientes = _recientes(ventas);

    final Map<String, InventoryModel> porNombre = {
      for (final i in inventory.items) i.productName: i,
    };

    const coloresProducto = [Color(0xFFBF8B66), Color(0xFFD9A155)];
    const coloresEstado = [Color(0xFFC8EBF4), Color(0xFFDCE9FE)];
    const iconosCliente = [Icons.face_3, Icons.face_6];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),
            Expanded(
              child: cargando
                  ? const Center(child: CircularProgressIndicator())
                  : conError
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                sales.errorMessage ??
                                    inventory.errorMessage ??
                                    'Ocurrió un error.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<SaleProvider>().fetchSales();
                                  context
                                      .read<InventoryProvider>()
                                      .fetchInventory();
                                },
                                child: const Text('Reintentar'),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
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
                                children: [
                                  TarjetaResumen(
                                    icono: Icons.payments_outlined,
                                    titulo: 'Ventas',
                                    cantidad: formatearMonto(total),
                                  ),
                                  TarjetaResumen(
                                    icono: Icons.shopping_bag_outlined,
                                    titulo: 'Pedidos',
                                    cantidad: '$pedidos',
                                  ),
                                  TarjetaResumen(
                                    icono: Icons.inventory_2_outlined,
                                    titulo: 'Stock',
                                    cantidad: '$stock',
                                  ),
                                  TarjetaResumen(
                                    icono: Icons.groups_2_outlined,
                                    titulo: 'Clientes',
                                    cantidad: '$clientes',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 18),
                              const EncabezadoSeccion(
                                titulo: 'Ventas de la semana',
                                accion: 'Ver más ›',
                              ),
                              const SizedBox(height: 8),
                              GraficaSemanal(valores: _ventasSemana(ventas)),
                              const SizedBox(height: 18),
                              const EncabezadoSeccion(
                                titulo: 'Productos más vendidos',
                              ),
                              const SizedBox(height: 8),
                              for (int i = 0; i < masVendidos.length; i++) ...[
                                ProductoDestacado(
                                  nombre: masVendidos[i].key,
                                  categoria:
                                      'Categoría: ${porNombre[masVendidos[i].key]?.categoryName ?? 'Sin categoría'}',
                                  unidades: '${masVendidos[i].value}',
                                  imagenUrl:
                                      porNombre[masVendidos[i].key]?.imagen ?? '',
                                  color: coloresProducto[i],
                                ),
                                const SizedBox(height: 8),
                              ],
                              const SizedBox(height: 10),
                              const EncabezadoSeccion(
                                titulo: 'Ventas recientes',
                              ),
                              const SizedBox(height: 8),
                              for (int i = 0; i < recientes.length; i++) ...[
                                VentaReciente(
                                  orden: '#ORD-${recientes[i].saleId}',
                                  cliente: recientes[i].customerName,
                                  precio: formatearMonto(recientes[i].saleTotal),
                                  estado: 'Completado',
                                  colorEstado: coloresEstado[i],
                                  iconoCliente: iconosCliente[i],
                                  colorCliente:
                                      const Color.fromARGB(255, 168, 170, 172),
                                ),
                                const SizedBox(height: 8),
                              ],
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