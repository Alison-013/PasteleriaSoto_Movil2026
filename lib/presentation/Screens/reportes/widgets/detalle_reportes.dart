import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_pasteleria_26/core/constants/reportes_formato.dart';

class LineaDetalle {
  final String producto;
  final int ordenes;
  final double monto;
 
  const LineaDetalle({
    required this.producto,
    required this.ordenes,
    required this.monto,
  });
}

class DetalleVentas extends StatelessWidget {
  final String rango;
  final List<LineaDetalle> lineas;

  const DetalleVentas({super.key, required this.rango, required this.lineas});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF1F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Detalle de Ventas',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: Text(
                  rango,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (lineas.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Sin ventas en este rango',
                style: GoogleFonts.playfairDisplay(color: Colors.grey),
              ),
            )
          else
            for (int i = 0; i < lineas.length; i++) ...[
              _ProductoVenta(
                producto: lineas[i].producto,
                ordenes: '${lineas[i].ordenes} '
                    '${lineas[i].ordenes == 1 ? 'orden' : 'órdenes'}',
                precio: formatearMonto(lineas[i].monto),
              ),
              if (i < lineas.length - 1)
                const Divider(height: 20, color: Color(0xFFEFF1F5)),
            ],
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
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                ordenes,
                style: GoogleFonts.playfairDisplay(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Text(
          precio,
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}