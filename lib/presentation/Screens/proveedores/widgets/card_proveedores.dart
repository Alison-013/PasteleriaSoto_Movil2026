import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/data/models/supplier_model.dart';

class CardProveedor extends StatelessWidget {
  final SupplierModel proveedor;
  final VoidCallback onTap;

  const CardProveedor({
    super.key,
    required this.proveedor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const iconoColor = Color(0xFF2E6BF2);
    const iconoBg = Color(0xFFEAF2FE);

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
                Icons.local_shipping_outlined,
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
                      Expanded(
                        child: Text(
                          proveedor.supplierName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Text(
                        proveedor.isActive ? "Activo" : "Inactivo",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: proveedor.isActive
                              ? const Color(0xFF158260)
                              : const Color(0xFFB04A4A),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    proveedor.codigo,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "PRODUCTOS",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    proveedor.detalle,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}