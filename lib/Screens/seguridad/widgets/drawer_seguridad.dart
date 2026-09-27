import 'package:flutter/material.dart';

import '/Widgets/menu_Widget.dart';

import 'cabecera_seguridad.dart';
import 'estilos_seguridad.dart';
import 'permisos_seguridad.dart';
import 'infousuario_seguridad.dart';

class DrawerPermisos extends StatefulWidget {
  final UsuarioInfo usuario;

  const DrawerPermisos({
    super.key,
    required this.usuario,
  });

  @override
  State<DrawerPermisos> createState() => _DrawerPermisosState();
}

class _DrawerPermisosState extends State<DrawerPermisos> {
  final Map<String, bool> _permisos = {
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

  void _cambiarPermiso(String permiso, bool valor) {
    setState(() {
      _permisos[permiso] = valor;
    });
  }

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
                            style: estiloPoppinsSeguridad(
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
                                style: estiloPlayfairSeguridad(
                                  19,
                                  FontWeight.w600,
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
                                style: estiloPoppinsSeguridad(
                                  8,
                                  const Color(0xFF526167),
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        CabeceraUsuario(usuario: widget.usuario),
                        const SizedBox(height: 10),
                        GrupoPermisos(
                          icono: Icons.storefront_outlined,
                          titulo: 'VENTAS Y FACTURACIÓN',
                          permisos: const [
                            'Ventas',
                            'Consultar historial y ventas del día',
                            'Realizar anulaciones y descuentos',
                          ],
                          valores: _permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 9),
                        GrupoPermisos(
                          icono: Icons.groups_outlined,
                          titulo: 'CLIENTES',
                          permisos: const [
                            'Consultar compras',
                            'Crear y editar fichas de clientes',
                          ],
                          valores: _permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 9),
                        GrupoPermisos(
                          icono: Icons.inventory_2_outlined,
                          titulo: 'PRODUCTOS E INVENTARIO',
                          permisos: const [
                            'Consultar catálogo y existencias',
                            'Modificar precios y recetas',
                            'Registrar ajustes o mermas',
                          ],
                          valores: _permisos,
                          alCambiar: _cambiarPermiso,
                        ),
                        const SizedBox(height: 9),
                        GrupoPermisos(
                          icono: Icons.settings_outlined,
                          titulo: 'COMPRAS REPORTES Y SEGURIDAD',
                          permisos: const [
                            'Registrar compras o pedidos',
                            'Ver reportes financieros',
                            'Modificar sistema y seguridad',
                          ],
                          valores: _permisos,
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
                              style: estiloPoppinsSeguridad(
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
                const menu_Widget(currentIndex: 4),
              ],
            ),
          ),
        );
      },
    );
  }
}