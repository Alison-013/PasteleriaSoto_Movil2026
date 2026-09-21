import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/TopBar_Widget.dart';
import 'Widgets/menu_Widget.dart';

class Proveedores extends StatefulWidget {
  const Proveedores({super.key});

  @override
  State<Proveedores> createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
  int _filtroActivo = 0;
  int _indiceMenu = 4;

  final filtros = ['Todos', 'Nombre', 'Email', 'Teléfono'];

  final proveedores = const [
    _ProveedorInfo(
      icono: Icons.apartment_outlined,
      nombre: 'PriceSmart Nicaragua',
      codigo: 'Cód: PRV-0010',
      detalle: 'Mayorista',
    ),
    _ProveedorInfo(
      icono: Icons.local_shipping_outlined,
      nombre: 'Distribuidora La Perfecta',
      codigo: 'Cód: PRV-0012',
      detalle: 'Lácteos',
    ),
    _ProveedorInfo(
      icono: Icons.inventory_2_outlined,
      nombre: 'Empaques & Cajas del Pacífico',
      codigo: 'Cód: PRV-00103',
      detalle: 'Cajas y Desechables',
    ),
    _ProveedorInfo(
      icono: Icons.balance_outlined,
      nombre: 'Molinera Central S.A.',
      codigo: 'Cód: PRV-00104',
      detalle: 'Harina',
    ),
    _ProveedorInfo(
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
                    Text(
                      'Más Opciones  >  Proveedores',
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF657278),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Proveedores',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 17,
                              height: 24 / 17,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF092535),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2F1F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '18 total',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF315E78),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Consulta de proveedores de la pastelería.',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        height: 14 / 10,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF657278),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 37,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: _caja(
                        borde: const Color(0xFFDCE3E7),
                        sombra: false,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            size: 16,
                            color: Color(0xFF79909C),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Buscar por nombre, código...',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF94A2A8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'DIRECTORIO REGISTRADO',
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF8A989E),
                      ),
                    ),
                    const SizedBox(height: 7),
                    SizedBox(
                      height: 28,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: filtros.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: 7),
                        itemBuilder: (context, index) {
                          final activo = _filtroActivo == index;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _filtroActivo = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: activo
                                    ? const Color(0xFF092535)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: activo
                                      ? const Color(0xFF092535)
                                      : const Color(0xFFDCE3E7),
                                ),
                              ),
                              child: Text(
                                filtros[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: activo
                                      ? Colors.white
                                      : const Color(0xFF657278),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...proveedores.map(
                      (proveedor) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _TarjetaProveedor(proveedor: proveedor),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const _Paginacion(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: menu_Widget(
        currentIndex: _indiceMenu,
        onTap: (indice) {
          setState(() {
            _indiceMenu = indice;
          });
        },
      ),
    );
  }
}

class _TarjetaProveedor extends StatelessWidget {
  const _TarjetaProveedor({required this.proveedor});

  final _ProveedorInfo proveedor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: _caja(),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFE1F1F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              proveedor.icono,
              size: 18,
              color: const Color(0xFF315E78),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proveedor.nombre,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    height: 15 / 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF092535),
                  ),
                ),
                Text(
                  '${proveedor.codigo} • ${proveedor.detalle}',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 8,
                    height: 11 / 8,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF7B8B92),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F8EF),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Activo',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF158260),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Paginacion extends StatelessWidget {
  const _Paginacion();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: _caja(),
      child: Row(
        children: [
          Text(
            'Página 1 de 3',
            style: GoogleFonts.poppins(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF657278),
            ),
          ),
          const Spacer(),
          const _BotonPagina(texto: '‹'),
          const SizedBox(width: 6),
          const _BotonPagina(texto: '1', activo: true),
          const SizedBox(width: 6),
          const _BotonPagina(texto: '2'),
          const SizedBox(width: 6),
          const _BotonPagina(texto: '3'),
          const SizedBox(width: 6),
          const _BotonPagina(texto: '›'),
        ],
      ),
    );
  }
}

class _BotonPagina extends StatelessWidget {
  const _BotonPagina({
    required this.texto,
    this.activo = false,
  });

  final String texto;
  final bool activo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF092535) : const Color(0xFFF0F3F4),
        shape: BoxShape.circle,
      ),
      child: Text(
        texto,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: activo ? Colors.white : const Color(0xFF526167),
        ),
      ),
    );
  }
}

class _ProveedorInfo {
  const _ProveedorInfo({
    required this.icono,
    required this.nombre,
    required this.codigo,
    required this.detalle,
  });

  final IconData icono;
  final String nombre;
  final String codigo;
  final String detalle;
}

BoxDecoration _caja({
  Color borde = Colors.transparent,
  bool sombra = true,
}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: borde),
    boxShadow: sombra
        ? const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ]
        : [],
  );
}