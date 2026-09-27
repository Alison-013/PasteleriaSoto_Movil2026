import 'package:flutter/material.dart';

import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';

import 'widgets/buscador_proveedores.dart';
import 'widgets/card_proveedores.dart';
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

  final List<String> _filtros = const [
    'Todos',
    'Nombre',
    'Email',
    'Teléfono',
  ];

  final List<ProveedorInfo> _proveedores = const [
    ProveedorInfo(
      icono: Icons.apartment_outlined,
      nombre: 'PriceSmart Nicaragua',
      codigo: 'Cód: PRV-0010',
      detalle: 'Mayorista',
    ),
    ProveedorInfo(
      icono: Icons.local_shipping_outlined,
      nombre: 'Distribuidora La Perfecta',
      codigo: 'Cód: PRV-0012',
      detalle: 'Lácteos',
    ),
    ProveedorInfo(
      icono: Icons.inventory_2_outlined,
      nombre: 'Empaques & Cajas del Pacífico',
      codigo: 'Cód: PRV-00103',
      detalle: 'Cajas y Desechables',
    ),
    ProveedorInfo(
      icono: Icons.balance_outlined,
      nombre: 'Molinera Central S.A.',
      codigo: 'Cód: PRV-00104',
      detalle: 'Harina',
    ),
    ProveedorInfo(
      icono: Icons.cake_outlined,
      nombre: 'Chocolates & Coberturas Puratos',
      codigo: 'Cód: PRV-00105',
      detalle: 'Chocolates y Pastelería',
    ),
  ];

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
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EncabezadoProveedores(),
                    const SizedBox(height: 10),
                    const BuscadorProveedores(),
                    const SizedBox(height: 10),
                    FiltrosProveedores(
                      filtros: _filtros,
                      filtroActivo: _filtroActivo,
                      onSeleccionar: (indice) {
                        setState(() {
                          _filtroActivo = indice;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    ..._proveedores.map(
                      (proveedor) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CardProveedor(proveedor: proveedor),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const PaginacionProveedores(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const menu_Widget(currentIndex: 4),
    );
  }
}