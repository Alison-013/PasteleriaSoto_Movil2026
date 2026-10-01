
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
  int _paginaActual = 1;

  final int _proveedoresPorPagina = 5;

  String _textoBusqueda = '';

  final List<String> _filtros = const [
    'Todos',
    'Activos',
    'Inactivos',
  ];

  final List<ProveedorInfo> _proveedores = const [
    ProveedorInfo(
      icono: Icons.apartment_outlined,
      nombre: 'PriceSmart Nicaragua',
      codigo: 'Cód: PRV-0010',
      detalle: 'Mayorista',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.local_shipping_outlined,
      nombre: 'Distribuidora La Perfecta',
      codigo: 'Cód: PRV-0012',
      detalle: 'Lácteos',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.inventory_2_outlined,
      nombre: 'Empaques & Cajas del Pacífico',
      codigo: 'Cód: PRV-00103',
      detalle: 'Cajas y Desechables',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.balance_outlined,
      nombre: 'Molinera Central S.A.',
      codigo: 'Cód: PRV-00104',
      detalle: 'Harina',
      activo: false,
    ),
    ProveedorInfo(
      icono: Icons.cake_outlined,
      nombre: 'Chocolates & Coberturas Puratos',
      codigo: 'Cód: PRV-00105',
      detalle: 'Chocolates y Pastelería',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.storefront_outlined,
      nombre: 'Distribuidora La Colonia',
      codigo: 'Cód: PRV-00106',
      detalle: 'Insumos',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.local_shipping_outlined,
      nombre: 'Comercial El Éxito',
      codigo: 'Cód: PRV-00107',
      detalle: 'Materias Primas',
      activo: false,
    ),
    ProveedorInfo(
      icono: Icons.inventory_outlined,
      nombre: 'Empaques del Sur',
      codigo: 'Cód: PRV-00108',
      detalle: 'Empaques',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.business_outlined,
      nombre: 'Importadora Central',
      codigo: 'Cód: PRV-00109',
      detalle: 'Productos Varios',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.store_outlined,
      nombre: 'Comercial San Marcos',
      codigo: 'Cód: PRV-00110',
      detalle: 'Repostería',
      activo: false,
    ),
    ProveedorInfo(
      icono: Icons.local_shipping_outlined,
      nombre: 'Distribuidora Nacional',
      codigo: 'Cód: PRV-00111',
      detalle: 'Alimentos',
      activo: true,
    ),
    ProveedorInfo(
      icono: Icons.business_outlined,
      nombre: 'Proveedora del Centro',
      codigo: 'Cód: PRV-00112',
      detalle: 'Insumos',
      activo: true,
    ),
  ];

  List<ProveedorInfo> get _proveedoresFiltrados {
    List<ProveedorInfo> resultado = _proveedores;

    // Filtro por estado
    if (_filtroActivo == 1) {
      resultado = resultado
          .where((proveedor) => proveedor.activo)
          .toList();
    } else if (_filtroActivo == 2) {
      resultado = resultado
          .where((proveedor) => !proveedor.activo)
          .toList();
    }

    // Búsqueda
    if (_textoBusqueda.trim().isNotEmpty) {
      final texto = _textoBusqueda.toLowerCase().trim();

      resultado = resultado.where((proveedor) {
        return proveedor.nombre.toLowerCase().contains(texto) ||
            proveedor.codigo.toLowerCase().contains(texto) ||
            proveedor.detalle.toLowerCase().contains(texto);
      }).toList();
    }

    return resultado;
  }

  int get _totalPaginas {
    if (_proveedoresFiltrados.isEmpty) {
      return 1;
    }

    return (_proveedoresFiltrados.length / _proveedoresPorPagina)
        .ceil();
  }

  List<ProveedorInfo> get _proveedoresPaginaActual {
    final inicio = (_paginaActual - 1) * _proveedoresPorPagina;

    return _proveedoresFiltrados
        .skip(inicio)
        .take(_proveedoresPorPagina)
        .toList();
  }

  void _cambiarFiltro(int indice) {
    setState(() {
      _filtroActivo = indice;
      _paginaActual = 1;
    });
  }

  void _cambiarPagina(int pagina) {
    setState(() {
      _paginaActual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    final proveedores = _proveedoresPaginaActual;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),

      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  12,
                  12,
                  14,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const EncabezadoProveedores(),

                    const SizedBox(height: 10),

                    BuscadorProveedores(
                      onChanged: (texto) {
                        setState(() {
                          _textoBusqueda = texto;
                          _paginaActual = 1;
                        });
                      },
                    ),

                    const SizedBox(height: 10),

                    FiltrosProveedores(
                      filtros: _filtros,
                      filtroActivo: _filtroActivo,
                      onSeleccionar: _cambiarFiltro,
                    ),

                    const SizedBox(height: 12),

                    if (proveedores.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 30,
                          ),
                          child: Text(
                            'No se encontraron proveedores.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      )
                    else
                      ...proveedores.map(
                        (proveedor) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: CardProveedor(
                            proveedor: proveedor,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),

                    PaginacionProveedores(
                      paginaActual: _paginaActual,
                      totalPaginas: _totalPaginas,
                      onPaginaSeleccionada: _cambiarPagina,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const menu_Widget(
        currentIndex: 4,
      ),
    );
  }
}
