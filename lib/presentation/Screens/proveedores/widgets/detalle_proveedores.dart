import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/data/models/supplier_model.dart';

void mostrarDetalleProveedor(BuildContext context, SupplierModel proveedor) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _DetalleProveedor(proveedor: proveedor),
  );
}

class _DetalleProveedor extends StatelessWidget {
  final SupplierModel proveedor;

  const _DetalleProveedor({required this.proveedor});

  @override
  Widget build(BuildContext context) {
    const iconoColor = Color(0xFF2E6BF2);
    const iconoBg = Color(0xFFEAF2FE);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ENCABEZADO
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: iconoBg,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_shipping_outlined,
                  size: 22,
                  color: iconoColor,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proveedor.supplierName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      proveedor.codigo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: proveedor.isActive
                      ? const Color(0xFFE2F8EF)
                      : const Color(0xFFF3E6E6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  proveedor.isActive ? "Activo" : "Inactivo",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: proveedor.isActive
                        ? const Color(0xFF158260)
                        : const Color(0xFFB04A4A),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _DatoProveedor(
            icono: Icons.phone_outlined,
            titulo: "TELÉFONO",
            valor: proveedor.phone,
          ),

          const SizedBox(height: 14),

          _DatoProveedor(
            icono: Icons.location_on_outlined,
            titulo: "UBICACIÓN",
            valor: proveedor.location,
          ),

          const SizedBox(height: 14),

          _DatoProveedor(
            icono: Icons.inventory_2_outlined,
            titulo: "PRODUCTOS",
            valor: proveedor.detalle,
          ),
        ],
      ),
    );
  }
}

class _DatoProveedor extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;

  const _DatoProveedor({
    required this.icono,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 18, color: Colors.grey),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  valor.isEmpty ? "No registrado" : valor,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF16233F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}