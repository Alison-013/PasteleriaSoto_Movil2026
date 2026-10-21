import 'package:flutter/material.dart';

import 'estilos_seguridad.dart';
import 'infousuario_seguridad.dart';

class TarjetaUsuario extends StatelessWidget {
  final UsuarioInfo usuario;
  final VoidCallback onTap;

  const TarjetaUsuario({
    super.key,
    required this.usuario,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: cajaSeguridad(),
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
                style: estiloPoppinsSeguridad(
                  11,
                  Colors.white,
                  FontWeight.w600,
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
                    style: estiloPoppinsSeguridad(
                      14,
                      const Color(0xFF202B30),
                      FontWeight.w600,
                    ),
                  ),
                  Text(
                    usuario.rol,
                    style: estiloPoppinsSeguridad(
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
                style: estiloPoppinsSeguridad(
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
      ),
    );
  }
}