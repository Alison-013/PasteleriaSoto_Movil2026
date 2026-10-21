import 'package:flutter/material.dart';

import 'estilos_seguridad.dart';

class GrupoPermisos extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final List<String> permisos;
  final Map<String, bool> valores;
  final void Function(String permiso, bool valor) alCambiar;

  const GrupoPermisos({
    super.key,
    required this.icono,
    required this.titulo,
    required this.permisos,
    required this.valores,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      decoration: cajaSeguridad(
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
                style: estiloPoppinsSeguridad(
                  9,
                  const Color(0xFF263238),
                  FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ...permisos.map((permiso) {
            final activo = valores[permiso] ?? false;

            return SizedBox(
              height: 28,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      permiso,
                      style: estiloPoppinsSeguridad(
                        9,
                        activo
                            ? const Color(0xFF263238)
                            : const Color(0xFF8B979C),
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.70,
                    child: Switch(
                      value: activo,
                      onChanged: (valor) => alCambiar(permiso, valor),
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF092535),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: const Color(0xFFE0E4E6),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}