import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalleVentas extends StatelessWidget {
  const DetalleVentas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Detalle de Ventas',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
              const Spacer(),
              Text(
                'Hoy',
                style: _estiloCaption(const Color(0xFF526167)),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const _ProductoVenta(
            producto: 'Pastel Selva Negra',
            ordenes: '24 órdenes',
            precio: r'$11,520.00',
          ),
          const Divider(height: 13),
          const _ProductoVenta(
            producto: 'Tarta de Frutos Rojos',
            ordenes: '18 órdenes',
            precio: r'$7,560.00',
          ),
          const Divider(height: 13),
          const _ProductoVenta(
            producto: 'Croissants de Almendra',
            ordenes: '35 órdenes',
            precio: r'$4,900.00',
          ),
          const Divider(height: 13),
          const _ProductoVenta(
            producto: 'Macarons Surtidos (x6)',
            ordenes: '15 órdenes',
            precio: r'$3,750.00',
          ),
        ],
      ),
    );
  }
}

class _ProductoVenta extends StatelessWidget {
  final String producto;
  final String ordenes;
  final String precio;

  const _ProductoVenta({
    required this.producto,
    required this.ordenes,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                producto,
                style: _estiloTexto(const Color(0xFF092535)),
              ),
              Text(
                ordenes,
                style: _estiloCaption(const Color(0xFF657278)),
              ),
            ],
          ),
        ),
        Text(
          precio,
          style: GoogleFonts.poppins(
            fontSize: 11,
            height: 14 / 11,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF092535),
          ),
        ),
      ],
    );
  }
}

TextStyle _estiloCaption(Color color) {
  return GoogleFonts.poppins(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle _estiloTexto(Color color) {
  return GoogleFonts.poppins(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
    color: color,
  );
}