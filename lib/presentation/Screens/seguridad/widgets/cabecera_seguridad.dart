import 'package:flutter/material.dart';
import 'estilos_seguridad.dart';
import 'infousuario_seguridad.dart';

class CabeceraUsuario extends StatelessWidget {
  final UsuarioInfo usuario;

  const CabeceraUsuario({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: cajaSeguridad(
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
              style: estiloPoppinsSeguridad(
                10,
                Colors.white,
                FontWeight.w600,
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
                  style: estiloPoppinsSeguridad(
                    12,
                    const Color(0xFF202B30),
                    FontWeight.w600,
                  ),
                ),
                Text(
                  usuario.rol,
                  style: estiloPoppinsSeguridad(
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
              color: usuario.activo
                  ? const Color(0xFFE2F8EF)
                  : const Color(0xFFF3E6E6),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              usuario.activo ? 'ACTIVO' : 'INACTIVO',
              style: estiloPoppinsSeguridad(
                8,
                usuario.activo
                    ? const Color(0xFF158260)
                    : const Color(0xFFB04A4A),
                FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}