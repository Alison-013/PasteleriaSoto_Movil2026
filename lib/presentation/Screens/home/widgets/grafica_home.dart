import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GraficaSemanal extends StatelessWidget {
  const GraficaSemanal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 5),
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
      child: CustomPaint(
        painter: _PintorGraficaSemanal(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _PintorGraficaSemanal extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lineaGuia = Paint()
      ..color = const Color(0xFFD4E0E5)
      ..strokeWidth = 1;

    for (double y = 15; y < size.height - 15; y += 24) {
      for (double x = 0; x < size.width; x += 6) {
        canvas.drawLine(Offset(x, y), Offset(x + 3, y), lineaGuia);
      }
    }

    final puntos = [
      Offset(0, 82),
      Offset(size.width * .16, 65),
      Offset(size.width * .32, 70),
      Offset(size.width * .48, 35),
      Offset(size.width * .64, 59),
      Offset(size.width * .80, 31),
      Offset(size.width, 43),
    ];

    final curva = Path()..moveTo(puntos.first.dx, puntos.first.dy);

    for (final punto in puntos.skip(1)) {
      curva.lineTo(punto.dx, punto.dy);
    }

    canvas.drawPath(
      curva,
      Paint()
        ..color = const Color(0xFF092535)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeJoin = StrokeJoin.round,
    );

    const dias = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

    for (int i = 0; i < dias.length; i++) {
      final texto = TextPainter(
        text: TextSpan(
          text: dias[i],
          style: GoogleFonts.poppins(
            fontSize: 11,
            height: 14 / 11,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF657278),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      texto.paint(
        canvas,
        Offset(i * size.width / 6, size.height - 12),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}