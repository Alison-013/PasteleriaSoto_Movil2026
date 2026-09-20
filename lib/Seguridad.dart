import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/TopBar_Widget.dart';
import 'Widgets/menu_Widget.dart';

class Seguridad extends StatefulWidget {
  const Seguridad({super.key});

  @override
  State<Seguridad> createState() => _SeguridadState();
}

class _SeguridadState extends State<Seguridad> {
  final usuarios = const [
    _Usuario(
      nombre: 'María Gómez',
      rol: 'Administrador',
      iniciales: 'MG',
      color: Color(0xFFB98264),
    ),
    _Usuario(
      nombre: 'Carlos Ruiz',
      rol: 'Vendedor',
      iniciales: 'CR',
      color: Color(0xFF8FA6B6),
    ),
    _Usuario(
      nombre: 'Ana Morales',
      rol: 'Cajera',
      iniciales: 'AM',
      color: Color(0xFFCE8755),
    ),
    _Usuario(
      nombre: 'Javier Soto',
      rol: 'Administrador',
      iniciales: 'JS',
      color: Color(0xFFBC976C),
    ),
    _Usuario(
      nombre: 'Kevin Marenco',
      rol: 'Cajero',
      iniciales: 'KM',
      color: Color(0xFF6F8391),
    ),
    _Usuario(
      nombre: 'Elena Rostrán',
      rol: 'Cajera',
      iniciales: 'ER',
      color: Color(0xFFE3C4B4),
    ),
  ];

  void _abrirPermisos(_Usuario usuario) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _DrawerPermisos(usuario: usuario);
      },
    );
  }

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
                      '← Volver a Opciones',
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF486878),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Seguridad',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 17,
                        height: 24 / 17,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF092535),
                      ),
                    ),
                    Text(
                      'Gestión de usuarios y permisos de acceso',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        height: 14 / 10,
                        color: const Color(0xFF657278),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(usuarios.length, (index) {
                      final usuario = usuarios[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: InkWell(
                          onTap: () {
                            if (index == 0) {
                              _abrirPermisos(usuario);
                            }
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: _TarjetaUsuario(usuario: usuario),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: menu_Widget(
        currentIndex: 4,
        onTap: (indice) {},
      ),
    );
  }
}

class _TarjetaUsuario extends StatelessWidget {
  const _TarjetaUsuario({required this.usuario});

  final _Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: _caja(),
      child: Row(
        children: [
          Container(
            width: 37,
            height: 37,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: usuario.color,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              usuario.iniciales,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usuario.nombre,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    height: 17 / 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF202B30),
                  ),
                ),
                Text(
                  usuario.rol,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF657278),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF2D8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Activo',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFD69A2D),
              ),
            ),
          ),
          const SizedBox(width: 7),
          const Icon(
            Icons.chevron_right,
            size: 18,
            color: Color(0xFF092535),
          ),
        ],
      ),
    );
  }
}

class _DrawerPermisos extends StatefulWidget {
  const _DrawerPermisos({required this.usuario});

  final _Usuario usuario;

  @override
  State<_DrawerPermisos> createState() => _DrawerPermisosState();
}

class _DrawerPermisosState extends State<_DrawerPermisos> {
  bool consultarVentas = true;
  bool consultarHistorial = true;
  bool anulaciones = false;

  bool consultarCompras = true;
  bool editarClientes = true;

  bool consultarInventario = true;
  bool modificarPrecios = false;
  bool registrarMermas = false;

  bool registrarCompras = false;
  bool reportesFinancieros = false;
  bool modificarSeguridad = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.70,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF8F7F7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(top: 8, bottom: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9C3C8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            '← Volver a Seguridad',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF486878),
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Detalle de Permisos',
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 19,
                                  height: 24 / 19,
                                  fontWeight: FontWeight.w600,
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
                                color: const Color(0xFFE8EDF1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '5 de 12 activos',
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF526167),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        _CabeceraUsuario(usuario: widget.usuario),
                        const SizedBox(height: 10),
                        _GrupoPermisos(
                          icono: Icons.storefront_outlined,
                          titulo: 'VENTAS Y FACTURACIÓN',
                          hijos: [
                            _SwitchPermiso(
                              texto: 'Ventas',
                              valor: consultarVentas,
                              alCambiar: (valor) {
                                setState(() {
                                  consultarVentas = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Consultar historial y ventas del día',
                              valor: consultarHistorial,
                              alCambiar: (valor) {
                                setState(() {
                                  consultarHistorial = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Realizar anulaciones y descuentos',
                              valor: anulaciones,
                              alCambiar: (valor) {
                                setState(() {
                                  anulaciones = valor;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        _GrupoPermisos(
                          icono: Icons.groups_outlined,
                          titulo: 'CLIENTES',
                          hijos: [
                            _SwitchPermiso(
                              texto: 'Consultar compras',
                              valor: consultarCompras,
                              alCambiar: (valor) {
                                setState(() {
                                  consultarCompras = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Crear y editar fichas de clientes',
                              valor: editarClientes,
                              alCambiar: (valor) {
                                setState(() {
                                  editarClientes = valor;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        _GrupoPermisos(
                          icono: Icons.inventory_2_outlined,
                          titulo: 'PRODUCTOS E INVENTARIO',
                          hijos: [
                            _SwitchPermiso(
                              texto: 'Consultar catálogo y existencias',
                              valor: consultarInventario,
                              alCambiar: (valor) {
                                setState(() {
                                  consultarInventario = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Modificar precios y recetas',
                              valor: modificarPrecios,
                              alCambiar: (valor) {
                                setState(() {
                                  modificarPrecios = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Registrar ajustes o mermas',
                              valor: registrarMermas,
                              alCambiar: (valor) {
                                setState(() {
                                  registrarMermas = valor;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        _GrupoPermisos(
                          icono: Icons.settings_outlined,
                          titulo: 'COMPRAS REPORTES Y SEGURIDAD',
                          hijos: [
                            _SwitchPermiso(
                              texto: 'Registrar compras o pedidos',
                              valor: registrarCompras,
                              alCambiar: (valor) {
                                setState(() {
                                  registrarCompras = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Ver reportes financieros',
                              valor: reportesFinancieros,
                              alCambiar: (valor) {
                                setState(() {
                                  reportesFinancieros = valor;
                                });
                              },
                            ),
                            _SwitchPermiso(
                              texto: 'Modificar sistema y seguridad',
                              valor: modificarSeguridad,
                              alCambiar: (valor) {
                                setState(() {
                                  modificarSeguridad = valor;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF092535),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            icon: const Icon(Icons.save_outlined, size: 15),
                            label: Text(
                              'Guardar Cambios',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                menu_Widget(
                  currentIndex: 4,
                  onTap: (indice) {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CabeceraUsuario extends StatelessWidget {
  const _CabeceraUsuario({required this.usuario});

  final _Usuario usuario;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: _caja(
        borde: const Color(0xFFDCE3E7),
        sombra: false,
      ),
      child: Row(
        children: [
          Container(
            width: 33,
            height: 33,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: usuario.color,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              usuario.iniciales,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usuario.nombre,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF202B30),
                  ),
                ),
                Text(
                  usuario.rol,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    color: const Color(0xFF657278),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F8EF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'ACTIVO',
              style: GoogleFonts.poppins(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF158260),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GrupoPermisos extends StatelessWidget {
  const _GrupoPermisos({
    required this.icono,
    required this.titulo,
    required this.hijos,
  });

  final IconData icono;
  final String titulo;
  final List<Widget> hijos;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      decoration: _caja(
        borde: const Color(0xFFD2D9DC),
        sombra: false,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icono, size: 14, color: const Color(0xFF092535)),
              const SizedBox(width: 5),
              Text(
                titulo,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF263238),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...hijos,
        ],
      ),
    );
  }
}

class _SwitchPermiso extends StatelessWidget {
  const _SwitchPermiso({
    required this.texto,
    required this.valor,
    required this.alCambiar,
  });

  final String texto;
  final bool valor;
  final ValueChanged<bool> alCambiar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          Expanded(
            child: Text(
              texto,
              style: GoogleFonts.poppins(
                fontSize: 9,
                fontWeight: FontWeight.w400,
                color: valor
                    ? const Color(0xFF263238)
                    : const Color(0xFF8B979C),
              ),
            ),
          ),
          Transform.scale(
            scale: 0.70,
            child: Switch(
              value: valor,
              onChanged: alCambiar,
              activeColor: Colors.white,
              activeTrackColor: const Color(0xFF092535),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFE0E4E6),
            ),
          ),
        ],
      ),
    );
  }
}

class _Usuario {
  const _Usuario({
    required this.nombre,
    required this.rol,
    required this.iniciales,
    required this.color,
  });

  final String nombre;
  final String rol;
  final String iniciales;
  final Color color;
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