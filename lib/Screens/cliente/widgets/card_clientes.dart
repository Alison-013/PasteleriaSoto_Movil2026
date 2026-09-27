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
      constraints: const BoxConstraints(minHeight: 64),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7F7),
        border: Border.all(color: const Color(0xFFD5DADF)),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: colorAvatar,
            child: Text(
              iniciales,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
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
                  nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF25282A),
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.call_outlined,
                      size: 10,
                      color: Color(0xFF636A70),
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        telefono,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF555B60),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
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
                      size: 9,
                      color: pocosPedidos
                          ? const Color(0xFF555B60)
                          : const Color(0xFF4776AE),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '$pedidos ${pedidos == 1 ? 'Pedido' : 'Pedidos'}',
                      style: TextStyle(
                        fontSize: 8,
                        color: pocosPedidos
                            ? const Color(0xFF555B60)
                            : const Color(0xFF4776AE),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 17,
                color: Color(0xFFB8C0C5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}