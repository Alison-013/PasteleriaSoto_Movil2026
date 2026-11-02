import 'package:flutter/material.dart';

class TarjetaCompra extends StatelessWidget {
  final String numero;
  final String proveedor;
  final String fecha;
  final String articulos;
  final String total;

  const TarjetaCompra({
    super.key,
    required this.numero,
    required this.proveedor,
    required this.fecha,
    required this.articulos,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    const iconoColor = Color(0xFF2E6BF2);
    const iconoBg = Color(0xFFEAF2FE);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF1F5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICONO
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: iconoBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 18,
              color: iconoColor,
            ),
          ),

          const SizedBox(width: 12),

          // INFORMACIÓN
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      numero,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      fecha,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),

                Text(
                  "Proveedor: $proveedor",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "ARTÍCULOS",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  articulos,
                  style: const TextStyle(fontSize: 13),
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "TOTAL",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      total,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF16233F),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
