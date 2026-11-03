import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/data/models/cliente_model.dart';

import 'avatar_cliente.dart';

class TarjetaCliente extends StatelessWidget {
  final CustomerModel cliente;
  final VoidCallback onTap;

  const TarjetaCliente({
    super.key,
    required this.cliente,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final pocosPedidos = cliente.pedidos <= 1;

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
            // AVATAR
            AvatarCliente(cliente: cliente),

            const SizedBox(width: 12),

            // INFORMACIÓN
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cliente.customerName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Row(
                    children: [
                      const Icon(
                        Icons.call_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Flexible(
                        child: Text(
                          cliente.phone.isEmpty ? "Sin teléfono" : cliente.phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // PEDIDOS
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: pocosPedidos
                          ? const Color(0xFFEFF1F5)
                          : const Color(0xFFEAF2FE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 12,
                          color: pocosPedidos
                              ? Colors.grey
                              : const Color(0xFF2E6BF2),
                        ),

                        const SizedBox(width: 4),

                        Text(
                          '${cliente.pedidos} ${cliente.pedidos == 1 ? 'Pedido' : 'Pedidos'}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: pocosPedidos
                                ? Colors.grey
                                : const Color(0xFF2E6BF2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ESTADO Y FLECHA
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: cliente.isActive
                        ? const Color(0xFFE2F8EF)
                        : const Color(0xFFF3E6E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    cliente.isActive ? "Activo" : "Inactivo",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: cliente.isActive
                          ? const Color(0xFF158260)
                          : const Color(0xFFB04A4A),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}