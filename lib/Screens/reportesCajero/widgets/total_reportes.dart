import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalVentas extends StatelessWidget {
  const TotalVentas({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.all(12),
      decoration: _decoracionTarjeta(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Ventas',
                  style: _estiloCaption(const Color(0xFF526167)),
                ),
                const Spacer(),
                Text(
                  r'$42,500.00',
                  style: _estiloTexto(const Color(0xFF092535)),
                ),
               
              ],
            ),
          ),
          Container(
            width: 54,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF3FD),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: Color(0xFF315E78),
              size: 20,
            ),
          ),
        ],
      ),
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

BoxDecoration _decoracionTarjeta() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(7),
    boxShadow: const [
      BoxShadow(
        color: Color(0x16000000),
        blurRadius: 8,
        offset: Offset(0, 3),
      ),
    ],
  );
}