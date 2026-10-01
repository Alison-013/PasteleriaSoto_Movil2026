
import 'package:flutter/material.dart';

class TarjetaCliente extends StatelessWidget {
  final String nombre;
  final String telefono;
  final int pedidos;
  final String iniciales;
  final Color colorAvatar;

  const TarjetaCliente({
    super.key,
    required this.nombre,
    required this.telefono,
    required this.pedidos,
    required this.iniciales,
    required this.colorAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final pocosPedidos = pedidos == 1;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 82,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7F7),
        border: Border.all(
          color: const Color(0xFFD5DADF),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [

          // AVATAR
          CircleAvatar(
            radius: 21,
            backgroundColor: colorAvatar,
            child: Text(
              iniciales,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(width: 13),

          // INFORMACIÓN DEL CLIENTE
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF25282A),
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.call_outlined,
                      size: 12,
                      color: Color(0xFF636A70),
                    ),

                    const SizedBox(width: 4),

                    Flexible(
                      child: Text(
                        telefono,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF555B60),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // PEDIDOS Y FLECHA
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: pocosPedidos
                      ? const Color(0xFFE8E8E8)
                      : const Color(0xFFD5E6FF),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 10,
                      color: pocosPedidos
                          ? const Color(0xFF555B60)
                          : const Color(0xFF4776AE),
                    ),

                    const SizedBox(width: 4),

                    Text(
                      '$pedidos ${pedidos == 1 ? 'Pedido' : 'Pedidos'}',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: pocosPedidos
                            ? const Color(0xFF555B60)
                            : const Color(0xFF4776AE),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

              const Icon(
                Icons.chevron_right,
                size: 19,
                color: Color(0xFFB8C0C5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
