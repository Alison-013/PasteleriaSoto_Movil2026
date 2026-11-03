import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';

class EncabezadoProveedores extends StatelessWidget {
  final int total;

  const EncabezadoProveedores({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // RUTA
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.mas),
          child: Row(
            children: const [
              Text(
                "Más Opciones",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 16,
                color: Colors.grey,
              ),
              Text(
                "Proveedores",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // TITULO
        Row(
          children: [
            const Text(
              "Proveedores",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(width: 8),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF1F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "$total total",
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        const Text(
          "Consulta de proveedores de la pastelería.",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}