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
    _Usuario('María Gómez', 'Administrador', 'MG', Color(0xFFB98264)),
    _Usuario('Carlos Ruiz', 'Vendedor', 'CR', Color(0xFF8FA6B6)),
    _Usuario('Ana Morales', 'Cajera', 'AM', Color(0xFFCE8755)),
    _Usuario('Javier Soto', 'Administrador', 'JS', Color(0xFFBC976C)),
    _Usuario('Kevin Marenco', 'Cajero', 'KM', Color(0xFF6F8391)),
    _Usuario('Elena Rostrán', 'Cajera', 'ER', Color(0xFFE3C4B4)),
  ];

  void _abrirPermisos(_Usuario usuario) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DrawerPermisos(usuario: usuario),
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
                      style: _poppins(
                        9,
                        const Color(0xFF486878),
                        FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Seguridad',
                      style: _playfair(17, FontWeight.w400),
                    ),
                    Text(
                      'Gestión de usuarios y permisos de acceso',
                      style: _poppins(
                        10,
                        const Color(0xFF657278),
                        FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ...List.generate(usuarios.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 9),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (index == 0) {
                              _abrirPermisos(usuarios[index]);
                            }
                          },
                          child: _TarjetaUsuario(usuario: usuarios[index]),
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
              style: _poppins(11, Colors.white, FontWeight.w600),
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
                  style: _poppins(
                    14,
                    const Color(0xFF202B30),
                    FontWeight.w600,
                  ),
                ),
                Text(
                  usuario.rol,
                  style: _poppins(
                    9,
                    const Color(0xFF657278),
                    FontWeight.w500,
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
              style: _poppins(
                8,
                const Color(0xFFD69A2D),
                FontWeight.w500,
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
  final Map<String, bool> permisos = {
    'Ventas': true,
    'Consultar historial y ventas del día': true,
    'Realizar anulaciones y descuentos': false,
    'Consultar compras': true,
    'Crear y editar fichas de clientes': true,
    'Consultar catálogo y existencias': true,
    'Modificar precios y recetas': false,
    'Registrar ajustes o mermas': false,
    'Registrar compras o pedidos': false,
    'Ver reportes financieros': false,
    'Modificar sistema y seguridad': false,
  };

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
                  margin: const EdgeInsets.only(top: 10, bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB9C3C8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Aquí no hay TopBar_Widget.
                // Por eso no aparece el contenedor azul de Pastelería Soto.

                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            '← Volver a Seguridad',
                            style: _poppins(
                              9,
                              const Color(0xFF486878),
                              FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Detalle de Permisos',
                                style: _playfair(19, FontWeight.w600),
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
                                style: _poppins(
                                  8,
                                  const Color(0xFF526167),
                                  FontWeight.w500,
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
                          permisos: [
                            'Ventas',
                            'Consultar historial y ventas del día',
                            'Realizar anulaciones y descuentos',
                          ],
                          valores: permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 9),
                        _GrupoPermisos(
                          icono: Icons.groups_outlined,
                          titulo: 'CLIENTES',
                          permisos: [
                            'Consultar compras',
                            'Crear y editar fichas de clientes',
                          ],
                          valores: permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 9),
                        _GrupoPermisos(
                          icono: Icons.inventory_2_outlined,
                          titulo: 'PRODUCTOS E INVENTARIO',
                          permisos: [
                            'Consultar catálogo y existencias',
                            'Modificar precios y recetas',
                            'Registrar ajustes o mermas',
                          ],
                          valores: permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 9),
                        _GrupoPermisos(
                          icono: Icons.settings_outlined,
                          titulo: 'COMPRAS REPORTES Y SEGURIDAD',
                          permisos: [
                            'Registrar compras o pedidos',
                            'Ver reportes financieros',
                            'Modificar sistema y seguridad',
                          ],
                          valores: permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.pop(context),
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
                              style: _poppins(
                                11,
                                Colors.white,
                                FontWeight.w600,
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

  void _cambiarPermiso(String permiso, bool valor) {
    setState(() {
      permisos[permiso] = valor;
    });
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
              style: _poppins(10, Colors.white, FontWeight.w600),
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
                  style: _poppins(
                    12,
                    const Color(0xFF202B30),
                    FontWeight.w600,
                  ),
                ),
                Text(
                  usuario.rol,
                  style: _poppins(
                    9,
                    const Color(0xFF657278),
                    FontWeight.w400,
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
              style: _poppins(
                8,
                const Color(0xFF158260),
                FontWeight.w600,
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
    required this.permisos,
    required this.valores,
    required this.alCambiar,
  });

  final IconData icono;
  final String titulo;
  final List<String> permisos;
  final Map<String, bool> valores;
  final void Function(String, bool) alCambiar;

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
                style: _poppins(
                  9,
                  const Color(0xFF263238),
                  FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...permisos.map(
            (permiso) => SizedBox(
              height: 28,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      permiso,
                      style: _poppins(
                        9,
                        valores[permiso]!
                            ? const Color(0xFF263238)
                            : const Color(0xFF8B979C),
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.70,
                    child: Switch(
                      value: valores[permiso]!,
                      onChanged: (valor) => alCambiar(permiso, valor),
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF092535),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFE0E4E6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Usuario {
  const _Usuario(this.nombre, this.rol, this.iniciales, this.color);

  final String nombre;
  final String rol;
  final String iniciales;
  final Color color;
}

TextStyle _poppins(double tamanio, Color color, FontWeight peso) {
  return GoogleFonts.poppins(
    fontSize: tamanio,
    fontWeight: peso,
    color: color,
  );
}

TextStyle _playfair(double tamanio, FontWeight peso) {
  return GoogleFonts.playfairDisplay(
    fontSize: tamanio,
    fontWeight: peso,
    color: const Color(0xFF092535),
  );
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