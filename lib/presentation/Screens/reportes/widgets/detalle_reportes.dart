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
                rango,
                style: _estiloCaption(const Color(0xFF526167)),
              ),
            ],
          ),
          const SizedBox(height: 7),
          if (lineas.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Sin ventas en este rango',
                style: _estiloCaption(const Color(0xFF526167)),
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
              if (i < lineas.length - 1) const Divider(height: 13),
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