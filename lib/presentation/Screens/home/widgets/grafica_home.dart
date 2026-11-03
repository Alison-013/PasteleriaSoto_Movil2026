import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GraficaSemanal extends StatelessWidget {
  final List<double> valores;
  const GraficaSemanal({super.key,  required this.valores});

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
        painter: _PintorGraficaSemanal(valores),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _PintorGraficaSemanal extends CustomPainter {
    final List<double> valores;
 
   _PintorGraficaSemanal(this.valores);

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

     final maximo = valores.fold<double>(0, (m, v) => math.max(m, v));
    const arriba = 15.0;
    final abajo = size.height - 25;
 
    final puntos = <Offset>[];
    for (int i = 0; i < valores.length; i++) {
      final proporcion = maximo == 0 ? 0.0 : valores[i] / maximo;
      puntos.add(Offset(
        i * size.width / (valores.length - 1),
        abajo - proporcion * (abajo - arriba),
      ));
    }
 
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
  bool shouldRepaint(covariant _PintorGraficaSemanal oldDelegate) =>
      oldDelegate.valores != valores;

}