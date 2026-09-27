import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngresosDia extends StatelessWidget {
  const IngresosDia({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 8),
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
                'Ingresos del Día',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz, size: 19),
            ],
          ),
          const SizedBox(height: 8),
          const Expanded(
            child: CustomPaint(
              painter: _PintorBarras(),
              child: SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PintorBarras extends CustomPainter {
  const _PintorBarras();

  @override
  void paint(Canvas canvas, Size size) {
    final alturas = [30.0, 45.0, 24.0, 61.0, 37.0, 68.0];
    final etiquetas = ['8am', '10am', '12pm', '2pm', '4pm', '6pm'];
    const espacio = 5.0;
    final ancho = (size.width - (espacio * 5)) / 6;

    for (int i = 0; i < alturas.length; i++) {
      final x = i * (ancho + espacio);
      final y = size.height - alturas[i] - 17;

      final color = i == 3
          ? const Color(0xFF092535)
          : const Color(0xFFBEE3FA);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, ancho, alturas[i]),
          const Radius.circular(1),
        ),
        Paint()..color = color,
      );

      final texto = TextPainter(
        text: TextSpan(
          text: etiquetas[i],
          style: GoogleFonts.poppins(
            fontSize: 8,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF526167),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      texto.paint(
        canvas,
        Offset(
          x + (ancho - texto.width) / 2,
          size.height - 11,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}