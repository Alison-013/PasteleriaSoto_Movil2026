import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widgets/TopBar_Widget.dart';
import 'Widgets/menu_Widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _indiceMenu = 0;

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
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2.05,
                      children: const [
                        _TarjetaResumen(
                          icono: Icons.payments_outlined,
                          titulo: 'Ventas',
                          cantidad: r'$1,850',
                        ),
                        _TarjetaResumen(
                          icono: Icons.shopping_bag_outlined,
                          titulo: 'Pedidos',
                          cantidad: '24',
                        ),
                        _TarjetaResumen(
                          icono: Icons.inventory_2_outlined,
                          titulo: 'Stock',
                          cantidad: '112',
                        ),
                        _TarjetaResumen(
                          icono: Icons.groups_2_outlined,
                          titulo: 'Clientes',
                          cantidad: '8',
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const _Encabezado(
                      titulo: 'Ventas de la semana',
                      accion: 'Ver más ›',
                    ),
                    const SizedBox(height: 8),
                    const _GraficaSemanal(),
                    const SizedBox(height: 18),
                    const _Encabezado(
                      titulo: 'Productos más vendidos',
                    ),
                    const SizedBox(height: 8),
                    const _Producto(
                      nombre: 'Pastel de Trufa',
                      categoria: 'Categoría: Postres',
                      unidades: '32',
                      icono: Icons.cake_outlined,
                      color: Color(0xFFBF8B66),
                    ),
                    const SizedBox(height: 8),
                    const _Producto(
                      nombre: 'Croissant Clásico',
                      categoria: 'Categoría: Panadería',
                      unidades: '28',
                      icono: Icons.bakery_dining_outlined,
                      color: Color(0xFFD9A155),
                    ),
                    const SizedBox(height: 18),
                    const _Encabezado(titulo: 'Ventas recientes'),
                    const SizedBox(height: 8),
                    const _Venta(
                      orden: '#ORD-1042',
                      cliente: 'María González',
                      precio: r'$45.00',
                      estado: 'Completado',
                      colorEstado: Color(0xFFC8EBF4),
                    ),
                    const SizedBox(height: 8),
                    const _Venta(
                      orden: '#ORD-1041',
                      cliente: 'Carlos Ruiz',
                      precio: r'$120.50',
                      estado: 'Preparando',
                      colorEstado: Color(0xFFDCE9FE),
                    ),
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

class _TarjetaResumen extends StatelessWidget {
  const _TarjetaResumen({
    required this.icono,
    required this.titulo,
    required this.cantidad,
  });

  final IconData icono;
  final String titulo;
  final String cantidad;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: _caja(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFE2F1F9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icono,
              size: 16,
              color: const Color(0xFF356379),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cantidad,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF092535),
                  ),
                ),
                Text(
                  titulo,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF657278),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({
    required this.titulo,
    this.accion,
  });

  final String titulo;
  final String? accion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            titulo,
            style: GoogleFonts.playfairDisplay(
              fontSize: 17,
              height: 24 / 17,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF092535),
            ),
          ),
        ),
        if (accion != null)
          Text(
            accion!,
            style: GoogleFonts.poppins(
              fontSize: 11,
              height: 14 / 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF547183),
            ),
          ),
      ],
    );
  }
}

class _GraficaSemanal extends StatelessWidget {
  const _GraficaSemanal();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 5),
      decoration: _caja(),
      child: CustomPaint(
        painter: _PintorGrafica(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _PintorGrafica extends CustomPainter {
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

class _Producto extends StatelessWidget {
  const _Producto({
    required this.nombre,
    required this.categoria,
    required this.unidades,
    required this.icono,
    required this.color,
  });

  final String nombre;
  final String categoria;
  final String unidades;
  final IconData icono;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61,
      padding: const EdgeInsets.all(7),
      decoration: _caja(),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(icono, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF263238),
                  ),
                ),
                Text(
                  categoria,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF657278),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                unidades,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
              Text(
                'uds',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  height: 14 / 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF657278),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Venta extends StatelessWidget {
  const _Venta({
    required this.orden,
    required this.cliente,
    required this.precio,
    required this.estado,
    required this.colorEstado,
  });

  final String orden;
  final String cliente;
  final String precio;
  final String estado;
  final Color colorEstado;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: _caja(),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xFFF0F2F3),
            child: Icon(
              Icons.person_outline,
              size: 16,
              color: Color(0xFF4E595F),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orden,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF657278),
                  ),
                ),
                Text(
                  cliente,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    height: 22 / 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF263238),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                precio,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  height: 24 / 17,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF092535),
                ),
              ),
              Container(
                color: colorEstado,
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 2,
                ),
                child: Text(
                  estado,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    height: 14 / 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF356379),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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