
import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';

class Compras_Screen extends StatefulWidget {
  const Compras_Screen({super.key});

  @override
  State<Compras_Screen> createState() => _ComprasScreenState();
}

class _ComprasScreenState extends State<Compras_Screen> {
  String _filtroActivo = "Todos";
  final List<String> _filtros = ["Todos", "Fecha"];

  final IconData _iconoCompra = Icons.shopping_bag_outlined;
  final Color _iconoColor = const Color(0xFF2E6BF2);
  final Color _iconoBg = const Color(0xFFEAF2FE);

  String _textoBusqueda = "";
  DateTime? _fechaSeleccionada;

  int _paginaActual = 1;
  final int _comprasPorPagina = 5;

  final List<Map<String, dynamic>> _compras = [
    {
      "numero": "Compra #00125",
      "ref": "Ref: OC-2026-0982",
      "articulos": "Cheesecakes Horneados, Muffins Variados (36 und.)",
      "total": "C\$8,450.00",
      "fecha": "30/09/2026",
    },
    {
      "numero": "Compra #00124",
      "ref": "Ref: OC-2026-0975",
      "articulos": "Croissants Horneados, Empanadas de Piña (40 und.)",
      "total": "C\$4,280.00",
      "fecha": "28/09/2026",
    },
    {
      "numero": "Compra #00123",
      "ref": "Ref: OC-2026-0960",
      "articulos": "Donas Glaseadas, Galletas Chocochip Empacadas (60 und.)",
      "total": "C\$2,150.00",
      "fecha": "25/09/2026",
    },
    {
      "numero": "Compra #00122",
      "ref": "Ref: OC-2026-0948",
      "articulos": "Pasteles Selva Negra, Brownies Gourmet (24 und.)",
      "total": "C\$6,750.00",
      "fecha": "22/09/2026",
    },
    {
      "numero": "Compra #00121",
      "ref": "Ref: OC-2026-0935",
      "articulos": "Postres Tres Leches, Tartaletas de Fruta (30 und.)",
      "total": "C\$5,320.00",
      "fecha": "20/09/2026",
    },
    {
      "numero": "Compra #00120",
      "ref": "Ref: OC-2026-0921",
      "articulos": "Harina, Azúcar y Chocolate para repostería.",
      "total": "C\$3,850.00",
      "fecha": "18/09/2026",
    },
    {
      "numero": "Compra #00119",
      "ref": "Ref: OC-2026-0914",
      "articulos": "Crema, Leche y Mantequilla para producción.",
      "total": "C\$2,980.00",
      "fecha": "15/09/2026",
    },
    {
      "numero": "Compra #00118",
      "ref": "Ref: OC-2026-0908",
      "articulos": "Fresas, Arándanos y Frutas variadas.",
      "total": "C\$4,620.00",
      "fecha": "12/09/2026",
    },
    {
      "numero": "Compra #00117",
      "ref": "Ref: OC-2026-0899",
      "articulos": "Cajas para pasteles y empaques personalizados.",
      "total": "C\$1,750.00",
      "fecha": "10/09/2026",
    },
    {
      "numero": "Compra #00116",
      "ref": "Ref: OC-2026-0887",
      "articulos": "Chocolate, cacao y chispas de chocolate.",
      "total": "C\$3,420.00",
      "fecha": "08/09/2026",
    },
    {
      "numero": "Compra #00115",
      "ref": "Ref: OC-2026-0875",
      "articulos": "Huevos, vainilla y productos para repostería.",
      "total": "C\$2,640.00",
      "fecha": "05/09/2026",
    },
    {
      "numero": "Compra #00114",
      "ref": "Ref: OC-2026-0864",
      "articulos": "Decoraciones, fondant y colorantes.",
      "total": "C\$2,210.00",
      "fecha": "02/09/2026",
    },
  ];

  // ------------------------------------------------------------
  // FILTRAR COMPRAS
  // ------------------------------------------------------------

  List<Map<String, dynamic>> get _comprasFiltradas {
    final busqueda = _textoBusqueda.trim().toLowerCase();

    return _compras.where((compra) {
      // BUSCADOR
      final coincideBusqueda =
          busqueda.isEmpty ||
          compra["numero"].toString().toLowerCase().contains(busqueda) ||
          compra["ref"].toString().toLowerCase().contains(busqueda) ||
          compra["articulos"].toString().toLowerCase().contains(busqueda);

      if (!coincideBusqueda) {
        return false;
      }

      // FILTRO POR FECHA
      if (_filtroActivo == "Fecha" && _fechaSeleccionada != null) {
        final fechaCompra = compra["fecha"].toString();

        final fechaBuscada =
            "${_fechaSeleccionada!.day.toString().padLeft(2, '0')}/"
            "${_fechaSeleccionada!.month.toString().padLeft(2, '0')}/"
            "${_fechaSeleccionada!.year}";

        return fechaCompra == fechaBuscada;
      }

      return true;
    }).toList();
  }

  // ------------------------------------------------------------
  // TOTAL DE PÁGINAS
  // ------------------------------------------------------------

  int get _totalPaginas {
    final total =
        (_comprasFiltradas.length / _comprasPorPagina).ceil();

    return total == 0 ? 1 : total;
  }

  // ------------------------------------------------------------
  // SELECCIONAR FECHA
  // ------------------------------------------------------------

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime(2026, 9, 30),
      firstDate: DateTime(2026, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );

    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
        _filtroActivo = "Fecha";
        _paginaActual = 1;
      });
    }
  }

  // ------------------------------------------------------------
  // LIMPIAR FILTRO
  // ------------------------------------------------------------

  void _limpiarFecha() {
    setState(() {
      _fechaSeleccionada = null;
      _filtroActivo = "Todos";
      _paginaActual = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inicio = (_paginaActual - 1) * _comprasPorPagina;

    final comprasDeLaPagina = _comprasFiltradas
        .skip(inicio)
        .take(_comprasPorPagina)
        .toList();

    // Si después de filtrar la página actual ya no existe,
    // volvemos automáticamente a la primera.
    if (_paginaActual > _totalPaginas) {
      _paginaActual = _totalPaginas;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const TopBar_Widget(),

              Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // RUTA
                    GestureDetector(
                      onTap: () => Navigator.pop(context),

                      child: Row(
                        children: const [
                          Text(
                            "Más Opciones",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Colors.grey,
                          ),

                          Text(
                            "Compras",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // TITULO
                    Row(
                      children: [
                        const Text(
                          "Compras",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF1F5),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Text(
                            "${_comprasFiltradas.length} total",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Consulta de compras realizadas a proveedores.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // BUSCADOR
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFE0E4EA),
                        ),
                      ),

                      child: TextField(
                        onChanged: (texto) {
                          setState(() {
                            _textoBusqueda = texto;
                            _paginaActual = 1;
                          });
                        },

                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),

                          hintText:
                              "Buscar por código, proveedor...",

                          border: InputBorder.none,

                          contentPadding:
                              EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ENCABEZADO
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          "HISTORIAL REGISTRADO",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),

                        Text(
                          _fechaSeleccionada == null
                              ? "Septiembre 2026"
                              : "${_fechaSeleccionada!.day.toString().padLeft(2, '0')}/"
                                "${_fechaSeleccionada!.month.toString().padLeft(2, '0')}/"
                                "${_fechaSeleccionada!.year}",

                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // FILTROS
                    SizedBox(
                      height: 40,

                      child: Row(
                        children: [

                          ..._filtros.map((filtro) {
                            final activo =
                                _filtroActivo == filtro;

                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 8),

                              child: GestureDetector(
                                onTap: () {

                                  if (filtro == "Fecha") {
                                    _seleccionarFecha();
                                  } else {
                                    _limpiarFecha();
                                  }
                                },

                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),

                                  decoration: BoxDecoration(
                                    color: activo
                                        ? const Color(0xFF16233F)
                                        : Colors.white,

                                    borderRadius:
                                        BorderRadius.circular(20),

                                    border: Border.all(
                                      color: activo
                                          ? const Color(0xFF16233F)
                                          : const Color(0xFFE0E4EA),
                                    ),
                                  ),

                                  child: Text(
                                    filtro,

                                    style: TextStyle(
                                      color: activo
                                          ? Colors.white
                                          : Colors.black87,

                                      fontWeight:
                                          FontWeight.w600,

                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),

                          // BOTÓN PARA QUITAR FECHA
                          if (_fechaSeleccionada != null)
                            GestureDetector(
                              onTap: _limpiarFecha,

                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // LISTA DE COMPRAS
                    if (comprasDeLaPagina.isEmpty)

                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 30),

                        child: Center(
                          child: Text(
                            "No se encontraron compras.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )

                    else

                      Column(
                        children:
                            comprasDeLaPagina.map((compra) {

                          return Container(
                            margin:
                                const EdgeInsets.only(bottom: 12),

                            padding:
                                const EdgeInsets.all(14),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(14),

                              border: Border.all(
                                color:
                                    const Color(0xFFEFF1F5),
                              ),
                            ),

                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [

                                // ICONO
                                Container(
                                  width: 36,
                                  height: 36,

                                  decoration: BoxDecoration(
                                    color: _iconoBg,
                                    shape: BoxShape.circle,
                                  ),

                                  child: Icon(
                                    _iconoCompra,
                                    size: 18,
                                    color: _iconoColor,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // INFORMACIÓN
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [

                                      Text(
                                        compra["numero"],
                                        style: const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),

                                      Text(
                                        compra["ref"],
                                        style:
                                            const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      const Text(
                                        "ARTÍCULOS",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight:
                                              FontWeight.w600,
                                        ),
                                      ),

                                      const SizedBox(height: 2),

                                      Text(
                                        compra["articulos"],
                                        style:
                                            const TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,

                                        children: [

                                          const Text(
                                            "TOTAL",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 11,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),

                                          Text(
                                            compra["total"],
                                            style:
                                                const TextStyle(
                                              fontWeight:
                                                  FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                                  Color(0xFF16233F),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 12),

                    // PAGINACIÓN
                    if (_totalPaginas > 1)
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            // ANTERIOR
                            InkWell(
                              onTap: _paginaActual > 1
                                  ? () {
                                      setState(() {
                                        _paginaActual--;
                                      });
                                    }
                                  : null,

                              child: Icon(
                                Icons.chevron_left,
                                size: 20,
                                color: _paginaActual > 1
                                    ? const Color(0xFF555B60)
                                    : const Color(0xFFBFC3C6),
                              ),
                            ),

                            const SizedBox(width: 6),

                            // NÚMEROS
                            ...List.generate(
                              _totalPaginas,
                              (index) {

                                final numero = index + 1;
                                final activo =
                                    _paginaActual == numero;

                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),

                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _paginaActual = numero;
                                      });
                                    },

                                    borderRadius:
                                        BorderRadius.circular(6),

                                    child: Container(
                                      width: 26,
                                      height: 26,

                                      alignment:
                                          Alignment.center,

                                      decoration: BoxDecoration(
                                        color: activo
                                            ? const Color(
                                                0xFF16233F)
                                            : const Color(
                                                0xFFF1F1F2),

                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),

                                      child: Text(
                                        "$numero",

                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: activo
                                              ? FontWeight.w600
                                              : FontWeight.w400,

                                          color: activo
                                              ? Colors.white
                                              : const Color(
                                                  0xFF555B60),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            const SizedBox(width: 6),

                            // SIGUIENTE
                            InkWell(
                              onTap: _paginaActual <
                                      _totalPaginas
                                  ? () {
                                      setState(() {
                                        _paginaActual++;
                                      });
                                    }
                                  : null,

                              child: Icon(
                                Icons.chevron_right,
                                size: 20,
                                color: _paginaActual <
                                        _totalPaginas
                                    ? const Color(0xFF555B60)
                                    : const Color(0xFFBFC3C6),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar:
          const menu_Widget(currentIndex: 4),
    );
  }
}
