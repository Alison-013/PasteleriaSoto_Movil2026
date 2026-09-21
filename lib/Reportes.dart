import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widgets/TopBar_Widget.dart';
import 'Widgets/menu_Widget.dart';

class Reportes extends StatefulWidget {
  const Reportes({super.key});

  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  int _filtroActivo = 0;
  int _indiceMenu = 2;

  final filtros = ['Por Día', 'Semanal', 'Por Mes', 'Anual'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reportes',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 17,
                        height: 24 / 17,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF092535),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 28,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: filtros.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 7),
                        itemBuilder: (context, index) {
                          final activo = _filtroActivo == index;

                          return InkWell(
                            onTap: () {
                              setState(() {
                                _filtroActivo = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 13),
                              decoration: BoxDecoration(
                                color: activo
                                    ? const Color(0xFF092535)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: activo
                                      ? const Color(0xFF092535)
                                      : const Color(0xFFDDE2E5),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                filtros[index],
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  height: 14 / 11,
                                  fontWeight: FontWeight.w500,
                                  color: activo
                                      ? Colors.white
                                      : const Color(0xFF526167),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 17),
                    const _TotalVentas(),
                    const SizedBox(height: 12),
                    const _IngresosDia(),
                    const SizedBox(height: 12),
                    const _DetalleVentas(),
                    const SizedBox(height: 12),
                    const _Paginacion(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: menu_Widget(
        currentIndex: _indiceMenu,
        onTap: (indice) {
          setState(() {
            _indiceMenu = indice;
          });
        },
      ),
    );
  }
}

class _TotalVentas extends StatelessWidget {
  const _TotalVentas();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      padding: const EdgeInsets.all(12),
      decoration: _caja(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Ventas',
                  style: _caption(const Color(0xFF526167)),
                ),
                const Spacer(),
                Text(
                  r'$42,500.00',
                  style: _body(const Color(0xFF092535)),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.trending_up,
                      color: Color(0xFF1C7994),
                      size: 14,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      '+12.5% vs ayer',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        height: 14 / 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1C7994),
                      ),
                    ),
                  ],
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

class _IngresosDia extends StatelessWidget {
  const _IngresosDia();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 8),
      decoration: _caja(),
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

class _DetalleVentas extends StatelessWidget {
  const _DetalleVentas();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: _caja(),
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
              Text('Hoy', style: _caption(const Color(0xFF526167))),
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
  const _ProductoVenta({
    required this.producto,
    required this.ordenes,
    required this.precio,
  });

  final String producto;
  final String ordenes;
  final String precio;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(producto, style: _body(const Color(0xFF092535))),
              Text(ordenes, style: _caption(const Color(0xFF657278))),
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

class _Paginacion extends StatelessWidget {
  const _Paginacion();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _caja(),
      child: Row(
        children: [
          Text('Página 1 de 3', style: _caption(const Color(0xFF526167))),
          const Spacer(),
          const _BotonPagina(texto: '‹'),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '1', activo: true),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '2'),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '3'),
          const SizedBox(width: 5),
          const _BotonPagina(texto: '›'),
        ],
      ),
    );
  }
}

class _BotonPagina extends StatelessWidget {
  const _BotonPagina({
    required this.texto,
    this.activo = false,
  });

  final String texto;
  final bool activo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 21,
      height: 21,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF092535) : const Color(0xFFF0F2F3),
        shape: BoxShape.circle,
      ),
      child: Text(
        texto,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: activo ? Colors.white : const Color(0xFF526167),
        ),
      ),
    );
  }
}

TextStyle _caption(Color color) {
  return GoogleFonts.poppins(
    fontSize: 11,
    height: 14 / 11,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle _body(Color color) {
  return GoogleFonts.poppins(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

BoxDecoration _caja() {
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