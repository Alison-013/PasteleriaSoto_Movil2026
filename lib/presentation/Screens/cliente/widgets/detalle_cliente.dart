import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/data/models/cliente_model.dart';

import 'avatar_cliente.dart';


void mostrarDetalleCliente(BuildContext context, CustomerModel cliente) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Cerrar detalle",
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 250),

    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: double.infinity,
            child: SafeArea(
              top: true,
              bottom: true,
              child: Column(
                children: [
                  // CABECERA
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
                    color: const Color(0xFFF4F6F9),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline),

                            const SizedBox(width: 8),

                            const Expanded(
                              child: Text(
                                "Detalle de cliente",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),

                        Text(
                          cliente.isActive ? "Cliente activo" : "Cliente inactivo",
                          style: TextStyle(
                            color: cliente.isActive
                                ? const Color(0xFF158260)
                                : const Color(0xFFB04A4A),
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CONTENIDO
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // AVATAR Y NOMBRE
                          Row(
                            children: [
                              AvatarCliente(cliente: cliente, tamano: 56),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  cliente.customerName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          _etiquetaSeccion("ESTADO"),
                          _cajaDato(
                            icono: Icons.circle,
                            iconoSize: 10,
                            iconoColor: cliente.isActive
                                ? const Color(0xFF158260)
                                : const Color(0xFFB04A4A),
                            valor: cliente.isActive ? "Activo" : "Inactivo",
                          ),

                          const SizedBox(height: 16),

                          _etiquetaSeccion("CÉDULA"),
                          _cajaDato(
                            icono: Icons.badge_outlined,
                            valor: cliente.cedula,
                          ),

                          const SizedBox(height: 16),

                          _etiquetaSeccion("TELÉFONO"),
                          _cajaDato(
                            icono: Icons.phone_outlined,
                            valor: cliente.phone,
                          ),

                          const SizedBox(height: 16),

                          _etiquetaSeccion("CIUDAD"),
                          _cajaDato(
                            icono: Icons.location_city_outlined,
                            valor: cliente.city,
                          ),

                          const SizedBox(height: 16),

                          _etiquetaSeccion("DIRECCIÓN"),
                          _cajaDato(
                            icono: Icons.location_on_outlined,
                            valor: cliente.customerAddress,
                          ),

                          const SizedBox(height: 16),

                          _etiquetaSeccion("PEDIDOS"),
                          _cajaDato(
                            icono: Icons.shopping_bag_outlined,
                            valor:
                                '${cliente.pedidos} ${cliente.pedidos == 1 ? 'pedido' : 'pedidos'}',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },

    // ANIMACIÓN
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
      );

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

// ETIQUETA DE SECCIÓN
Widget _etiquetaSeccion(String texto) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      texto,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  );
}

// CAJA DE DATO
Widget _cajaDato({
  required IconData icono,
  required String valor,
  double iconoSize = 16,
  Color iconoColor = Colors.grey,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFF4F6F9),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Icon(icono, size: iconoSize, color: iconoColor),

        const SizedBox(width: 8),

        Expanded(
          child: Text(
            valor.isEmpty ? "No registrado" : valor,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}