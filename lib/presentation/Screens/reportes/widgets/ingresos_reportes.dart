import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngresosDia extends StatelessWidget {
  final List<String> etiquetas;
  final List<double> valores;
  
  const IngresosDia({super.key, required this.etiquetas, required this.valores});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            child: valores.isEmpty
                ? Center(
                    child: Text(
                      'Sin ventas en este rango',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF526167),
                      ),
                    ),
                  )
                : CustomPaint(
                    painter: _PintorBarras(etiquetas, valores),
                    child: const SizedBox.expand(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _PintorBarras extends CustomPainter {
  final List<String> etiquetas;
  final List<double> alturas;

  const _PintorBarras(this.etiquetas, this.alturas);

  @override
  void paint(Canvas canvas, Size size) {
    final n = alturas.length;
    const espacio = 5.0;
    
    final anchoCalculado = (size.width - (espacio * (n - 1))) / n;
    final ancho = anchoCalculado > 60 ? 60.0 : anchoCalculado;
    final anchoTotal = (ancho * n) + (espacio * (n - 1));
    final inicioX = (size.width - anchoTotal) / 2;
    

    final valorMaximo = alturas.reduce((a, b) => a > b ? a : b);
    final altoUtil = size.height - 20; // deja espacio para las etiquetas
    final factor = valorMaximo > 0 ? altoUtil / valorMaximo : 0.0;
    final indiceMaximo = alturas.indexOf(valorMaximo);

    for (int i = 0; i < n; i++) {
      final x = inicioX + i * (ancho + espacio);
      final alturaBarra = alturas[i] * factor;
      final y = size.height - alturaBarra - 17;
 
      final color = i == indiceMaximo
          ? const Color(0xFF092535)
          : const Color(0xFFBEE3FA);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, y, ancho, alturaBarra),
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
  bool shouldRepaint(covariant _PintorBarras oldDelegate) =>
      oldDelegate.alturas != alturas || oldDelegate.etiquetas != etiquetas;}