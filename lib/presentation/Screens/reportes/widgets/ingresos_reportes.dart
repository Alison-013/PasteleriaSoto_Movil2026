import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IngresosDia extends StatelessWidget {
  final List<String> etiquetas;
  final List<double> valores;

  const IngresosDia({super.key, required this.etiquetas, required this.valores});

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
          Text(
            'Ingresos del Día',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: valores.isEmpty
                ? Center(
                    child: Text(
                      'Sin ventas en este rango',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : CustomPaint(
                    painter: _PintorBarras(etiquetas, valores),
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
    final altoUtil = size.height - 26; // deja espacio para las etiquetas
    final factor = valorMaximo > 0 ? altoUtil / valorMaximo : 0.0;
    final indiceMaximo = alturas.indexOf(valorMaximo);

    for (int i = 0; i < n; i++) {
      final x = inicioX + i * (ancho + espacio);
      final alturaBarra = alturas[i] * factor;
      final y = size.height - alturaBarra - 22;
 
      final color = i == indiceMaximo
          ? const Color(0xFF16233F)
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
            fontSize: 11,
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
          size.height - 16,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PintorBarras oldDelegate) =>
      oldDelegate.alturas != alturas || oldDelegate.etiquetas != etiquetas;}