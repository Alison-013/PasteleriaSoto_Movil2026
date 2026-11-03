import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEFF1F5)),
        ),
        child: Row(
          children: [
            // INICIALES
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: usuario.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                usuario.iniciales,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // INFORMACIÓN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usuario.nombre,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    usuario.rol,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ESTADO
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: usuario.activo
                    ? const Color(0xFFE2F8EF)
                    : const Color(0xFFF3E6E6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                usuario.activo ? "Activo" : "Inactivo",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: usuario.activo
                      ? const Color(0xFF158260)
                      : const Color(0xFFB04A4A),
                ),
              ),
            ),

            const SizedBox(width: 6),

            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}