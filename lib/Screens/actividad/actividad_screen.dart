
import 'widgets/actividades_widget.dart';
import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';
import 'package:google_fonts/google_fonts.dart';

class Activity_Screen extends StatefulWidget {
  const Activity_Screen({super.key});

  @override
  State<Activity_Screen> createState() => _ActividadScreenState();
}

class _ActividadScreenState extends State<Activity_Screen> {

  // ============================================================
  // BUSCADOR Y FILTROS
  // ============================================================

  String _textoBusqueda = "";

  DateTime? _fechaDesde;
  DateTime? _fechaHasta;

  final TextEditingController _buscadorController =
      TextEditingController();

  // ============================================================
  // PAGINACIÓN
  // ============================================================

  int _paginaActual = 1;

  final int _elementosPorPagina = 5;

  // ============================================================
  // ACTIVIDADES FILTRADAS
  // ============================================================

  List<Map<String, dynamic>> get _actividadesFiltradas {
    return actividades.where((actividad) {

      final texto = _textoBusqueda.toLowerCase().trim();

      final coincideBusqueda =
          actividad["tipo"]
                  .toString()
                  .toLowerCase()
                  .contains(texto) ||
              actividad["tituloNormal"]
                  .toString()
                  .toLowerCase()
                  .contains(texto) ||
              actividad["tituloBold"]
                  .toString()
                  .toLowerCase()
                  .contains(texto) ||
              actividad["descripcion"]
                  .toString()
                  .toLowerCase()
                  .contains(texto) ||
              actividad["usuarioCorto"]
                  .toString()
                  .toLowerCase()
                  .contains(texto) ||
              actividad["detalle"]["usuarioNombre"]
                  .toString()
                  .toLowerCase()
                  .contains(texto);

      final DateTime fechaActividad = actividad["fecha"];

      bool coincideFecha = true;

      if (_fechaDesde != null) {
        coincideFecha =
            !fechaActividad.isBefore(_fechaDesde!);
      }

      if (_fechaHasta != null) {
        final fechaFin = DateTime(
          _fechaHasta!.year,
          _fechaHasta!.month,
          _fechaHasta!.day,
          23,
          59,
          59,
        );

        coincideFecha =
            coincideFecha &&
            !fechaActividad.isAfter(fechaFin);
      }

      return coincideBusqueda && coincideFecha;
    }).toList();
  }

  // ============================================================
  // ACTIVIDADES DE LA PÁGINA ACTUAL
  // ============================================================

  List<Map<String, dynamic>> get _actividadesPaginaActual {

    final actividades = _actividadesFiltradas;

    final inicio =
        (_paginaActual - 1) * _elementosPorPagina;

    if (inicio >= actividades.length) {
      return [];
    }

    final fin =
        (inicio + _elementosPorPagina > actividades.length)
            ? actividades.length
            : inicio + _elementosPorPagina;

    return actividades.sublist(inicio, fin);
  }

  // ============================================================
  // TOTAL DE PÁGINAS
  // ============================================================

  int get _totalPaginas {

    if (_actividadesFiltradas.isEmpty) {
      return 1;
    }

    return (_actividadesFiltradas.length /
            _elementosPorPagina)
        .ceil();
  }

  // ============================================================
  // SELECCIONAR FECHA DESDE
  // ============================================================

  Future<void> _seleccionarFechaDesde() async {

    final fecha = await showDatePicker(
      context: context,
      initialDate:
          _fechaDesde ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (fecha != null) {

      setState(() {
        _fechaDesde = fecha;
        _paginaActual = 1;
      });
    }
  }

  // ============================================================
  // SELECCIONAR FECHA HASTA
  // ============================================================

  Future<void> _seleccionarFechaHasta() async {

    final fecha = await showDatePicker(
      context: context,
      initialDate:
          _fechaHasta ??
          _fechaDesde ??
          DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (fecha != null) {

      setState(() {
        _fechaHasta = fecha;
        _paginaActual = 1;
      });
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

@override
Widget build(BuildContext context) {
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
                  // ==================================================
                  // TITULO
                  // ==================================================

                  Text(
                    "Registros del Sistema",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF092535),
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Historial cronológico de actividades administrativas.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // BUSCADOR
                  // ==================================================

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
                      controller: _buscadorController,
                      onChanged: (valor) {
                        setState(() {
                          _textoBusqueda = valor;
                          _paginaActual = 1;
                        });
                      },
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: "Buscar registros...",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        suffixIcon: _textoBusqueda.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  _buscadorController.clear();

                                  setState(() {
                                    _textoBusqueda = "";
                                    _paginaActual = 1;
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // FILTROS POR FECHA
                  // ==================================================

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: _seleccionarFechaDesde,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE0E4EA),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: Color(0xFF16233F),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    _fechaDesde == null
                                        ? "Fecha desde"
                                        : "${_fechaDesde!.day.toString().padLeft(2, '0')}/"
                                          "${_fechaDesde!.month.toString().padLeft(2, '0')}/"
                                          "${_fechaDesde!.year}",
                                    style: TextStyle(
                                      color: _fechaDesde == null
                                          ? Colors.grey
                                          : Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: InkWell(
                          onTap: _seleccionarFechaHasta,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFE0E4EA),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                  color: Color(0xFF16233F),
                                ),

                                const SizedBox(width: 8),

                                Expanded(
                                  child: Text(
                                    _fechaHasta == null
                                        ? "Fecha hasta"
                                        : "${_fechaHasta!.day.toString().padLeft(2, '0')}/"
                                          "${_fechaHasta!.month.toString().padLeft(2, '0')}/"
                                          "${_fechaHasta!.year}",
                                    style: TextStyle(
                                      color: _fechaHasta == null
                                          ? Colors.grey
                                          : Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ==================================================
                  // LIMPIAR FILTROS
                  // ==================================================

                  if (_fechaDesde != null ||
                      _fechaHasta != null ||
                      _textoBusqueda.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          _buscadorController.clear();

                          setState(() {
                            _textoBusqueda = "";
                            _fechaDesde = null;
                            _fechaHasta = null;
                            _paginaActual = 1;
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 16,
                        ),
                        label: const Text(
                          "Limpiar filtros",
                        ),
                      ),
                    ),

                  const SizedBox(height: 8),

                  // ==================================================
                  // FECHA MOSTRADA
                  // ==================================================

                  Center(
                    child: Text(
                      _fechaDesde == null && _fechaHasta == null
                          ? "TODAS LAS ACTIVIDADES"
                          : _textoFechas(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ==================================================
                  // LISTA DE ACTIVIDADES
                  // ==================================================

                  if (_actividadesFiltradas.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFEFF1F5),
                        ),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 40,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "No se encontraron registros",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Prueba con otro término o rango de fechas.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      children: _actividadesPaginaActual.map(
                        (actividad) {
                          return GestureDetector(
                            onTap: () => _mostrarDetalle(
                              context,
                              actividad,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 12,
                              ),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFEFF1F5),
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
                                      color: actividad["iconoBg"],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      actividad["icono"],
                                      size: 18,
                                      color: actividad["iconoColor"],
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // TITULO
                                        RichText(
                                          text: TextSpan(
                                            style:
                                                GoogleFonts.playfairDisplay(
                                              color: Colors.black87,
                                              fontSize: 14,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: actividad[
                                                    "tituloNormal"],
                                              ),
                                              TextSpan(
                                                text: actividad[
                                                    "tituloBold"],
                                                style: GoogleFonts
                                                    .playfairDisplay(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(height: 2),

                                        // HORA
                                        Text(
                                          actividad["hora"],
                                          style:
                                              GoogleFonts.playfairDisplay(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),

                                        const SizedBox(height: 6),

                                        // DESCRIPCIÓN
                                        Text(
                                          actividad["descripcion"],
                                          style:
                                              GoogleFonts.playfairDisplay(
                                            color: Colors.black54,
                                            fontSize: 13,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: (actividad[
                                                            "tagColor"]
                                                        as Color)
                                                    .withOpacity(0.12),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                actividad["tipo"],
                                                style: GoogleFonts
                                                    .playfairDisplay(
                                                  color: actividad[
                                                      "tagColor"],
                                                  fontSize: 11,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            const SizedBox(width: 8),

                                            Icon(
                                              Icons.person_outline,
                                              size: 14,
                                              color:
                                                  Colors.grey.shade500,
                                            ),

                                            const SizedBox(width: 2),

                                            Text(
                                              actividad["usuarioCorto"],
                                              style: GoogleFonts
                                                  .playfairDisplay(
                                                color:
                                                    Colors.grey.shade600,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),

                  const SizedBox(height: 12),

                  // ==================================================
                  // PAGINACIÓN
                  // ==================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Página $_paginaActual de $_totalPaginas",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(width: 8),

                      IconButton(
                        onPressed: _paginaActual > 1
                            ? () {
                                setState(() {
                                  _paginaActual--;
                                });
                              }
                            : null,
                        icon: const Icon(
                          Icons.chevron_left,
                        ),
                        color: const Color(0xFF16233F),
                      ),

                      const SizedBox(width: 2),

                      ...List.generate(
                        _totalPaginas,
                        (index) {
                          final numero = index + 1;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _paginaActual = numero;
                                });
                              },
                              child: _numeroPagina(
                                numero,
                                activo:
                                    _paginaActual == numero,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 2),

                      IconButton(
                        onPressed:
                            _paginaActual < _totalPaginas
                                ? () {
                                    setState(() {
                                      _paginaActual++;
                                    });
                                  }
                                : null,
                        icon: const Icon(
                          Icons.chevron_right,
                        ),
                        color: const Color(0xFF16233F),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),

    bottomNavigationBar: const menu_Widget(
      currentIndex: 3,
    ),
  );
}

  // ============================================================
  // TEXTO DE FECHAS
  // ============================================================

  String _textoFechas() {

    if (_fechaDesde != null &&
        _fechaHasta != null) {

      return "${_fechaDesde!.day.toString().padLeft(2, '0')}/"
          "${_fechaDesde!.month.toString().padLeft(2, '0')}/"
          "${_fechaDesde!.year}"
          " - "
          "${_fechaHasta!.day.toString().padLeft(2, '0')}/"
          "${_fechaHasta!.month.toString().padLeft(2, '0')}/"
          "${_fechaHasta!.year}";
    }

    if (_fechaDesde != null) {

      return "DESDE "
          "${_fechaDesde!.day.toString().padLeft(2, '0')}/"
          "${_fechaDesde!.month.toString().padLeft(2, '0')}/"
          "${_fechaDesde!.year}";
    }

    return "HASTA "
        "${_fechaHasta!.day.toString().padLeft(2, '0')}/"
        "${_fechaHasta!.month.toString().padLeft(2, '0')}/"
        "${_fechaHasta!.year}";
  }

  // ============================================================
  // NÚMERO DE PÁGINA
  // ============================================================

  Widget _numeroPagina(
    int numero, {
    required bool activo,
  }) {

    return Container(
      width: 28,
      height: 28,

      alignment:
          Alignment.center,

      decoration:
          BoxDecoration(
        color: activo
            ? const Color(0xFF16233F)
            : Colors.white,

        shape:
            BoxShape.circle,

        border:
            Border.all(
          color:
              const Color(0xFFE0E4EA),
        ),
      ),

      child:
          Text(
        "$numero",

        style:
            TextStyle(
          color: activo
              ? Colors.white
              : Colors.black87,
        ),
      ),
    );
  }

  // ============================================================
  // DETALLE
  // ============================================================

  void _mostrarDetalle(
    BuildContext context,
    Map<String, dynamic> actividad,
  ) {

    final detalle =
        actividad["detalle"];

    showGeneralDialog(
      context: context,

      barrierDismissible: true,

      barrierLabel:
          "Cerrar detalle",

      barrierColor:
          Colors.black.withOpacity(
        0.4,
      ),

      transitionDuration:
          const Duration(
        milliseconds: 250,
      ),

      pageBuilder:
          (
        context,
        animation,
        secondaryAnimation,
      ) {

        return Align(
          alignment:
              Alignment.centerRight,

          child:
              Material(
            color:
                Colors.white,

            child:
                SizedBox(
              width:
                  MediaQuery.of(context)
                          .size
                          .width *
                      0.85,

              height:
                  double.infinity,

              child:
                  SafeArea(
                child:
                    Column(
                  children: [

                    // CABECERA
                    Container(
                      width:
                          double.infinity,

                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        20,
                        16,
                        12,
                        16,
                      ),

                      color:
                          const Color(
                        0xFFF4F6F9,
                      ),

                      child:
                          Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Row(
                            children: [

                              Icon(
                                actividad[
                                    "icono"],

                                color:
                                    actividad[
                                                "iconoColor"] ==
                                            Colors.white
                                        ? Colors.black
                                        : actividad[
                                            "iconoColor"],
                              ),

                              const SizedBox(
                                  width: 8),

                              const Expanded(
                                child:
                                    Text(
                                  "Detalle de actividad",
                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    fontSize:
                                        16,
                                  ),
                                ),
                              ),

                              IconButton(
                                icon:
                                    const Icon(
                                  Icons.close,
                                ),

                                onPressed:
                                    () =>
                                        Navigator.pop(
                                  context,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            actividad[
                                "tipo"],

                            style:
                                TextStyle(
                              color:
                                  actividad[
                                      "tagColor"],

                              fontWeight:
                                  FontWeight
                                      .w600,

                              fontSize:
                                  12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CONTENIDO
                    Expanded(
                      child:
                          SingleChildScrollView(

                        padding:
                            const EdgeInsets
                                .fromLTRB(
                          20,
                          20,
                          20,
                          0,
                        ),

                        child:
                            Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            _etiquetaSeccion(
                              "FECHA Y HORA",
                            ),

                            Container(
                              width:
                                  double.infinity,

                              padding:
                                  const EdgeInsets
                                      .all(
                                12,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFFF4F6F9,
                                ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  10,
                                ),
                              ),

                              child:
                                  Row(
                                children: [

                                  const Icon(
                                    Icons
                                        .access_time,
                                    size: 16,
                                    color:
                                        Colors.grey,
                                  ),

                                  const SizedBox(
                                      width: 6),

                                  Text(
                                    detalle[
                                        "fechaHora"],

                                    style:
                                        const TextStyle(
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                                height: 16),

                            _etiquetaSeccion(
                              "USUARIO RESPONSABLE",
                            ),

                            Container(
                              width:
                                  double.infinity,

                              padding:
                                  const EdgeInsets
                                      .all(
                                12,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFFF4F6F9,
                                ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  10,
                                ),
                              ),

                              child:
                                  Row(
                                children: [

                                  CircleAvatar(
                                    backgroundColor:
                                        const Color(
                                      0xFFEAF2FE,
                                    ),

                                    child:
                                        Text(
                                      _iniciales(
                                        detalle[
                                            "usuarioNombre"],
                                      ),

                                      style:
                                          const TextStyle(
                                        color:
                                            Color(
                                          0xFF2E6BF2,
                                        ),

                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                      width: 10),

                                  Expanded(
                                    child:
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(
                                          detalle[
                                              "usuarioNombre"],

                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),

                                        Text(
                                          detalle[
                                              "usuarioEmail"],

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.grey,
                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                                height: 16),

                            _etiquetaSeccion(
                              "DETALLE AFECTADO",
                            ),

                            Container(
                              width:
                                  double.infinity,

                              padding:
                                  const EdgeInsets
                                      .all(
                                12,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFFF4F6F9,
                                ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  10,
                                ),
                              ),

                              child:
                                  Row(
                                children: [

                                  Expanded(
                                    child:
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,

                                      children: [

                                        Text(
                                          detalle[
                                              "productoNombre"],

                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),
                                        ),

                                        Text(
                                          detalle[
                                              "productoSku"],

                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.grey,
                                            fontSize:
                                                12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal:
                                          8,
                                      vertical:
                                          4,
                                    ),

                                    decoration:
                                        BoxDecoration(
                                      color:
                                          Colors.white,

                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                        8,
                                      ),
                                    ),

                                    child:
                                        Text(
                                      detalle[
                                          "productoCategoria"],

                                      style:
                                          const TextStyle(
                                        fontSize:
                                            12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                                height: 16),

                            _etiquetaSeccion(
                              "DESCRIPCIÓN DE LA ACCIÓN",
                            ),

                            Text(
                              detalle[
                                  "descripcionLarga"],

                              style:
                                  const TextStyle(
                                fontSize:
                                    13,
                              ),
                            ),

                            const SizedBox(
                                height: 16),

                            if (detalle[
                                    "valorAnterior"] !=
                                null) ...[

                              _etiquetaSeccion(
                                "COMPARATIVA DE VALORES",
                              ),

                              Row(
                                children: [

                                  Expanded(
                                    child:
                                        _cajaValor(
                                      "VALOR ANTERIOR",

                                      detalle[
                                          "valorAnterior"],

                                      tachado:
                                          true,
                                    ),
                                  ),

                                  const SizedBox(
                                      width: 10),

                                  Expanded(
                                    child:
                                        _cajaValor(
                                      "VALOR ACTUALIZADO",

                                      detalle[
                                          "valorNuevo"],

                                      tachado:
                                          false,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                  height: 16),
                            ],

                            _etiquetaSeccion(
                              "ESTADO DE OPERACIÓN",
                            ),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal:
                                    10,
                                vertical:
                                    8,
                              ),

                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFFE9F9EF,
                                ),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  8,
                                ),
                              ),

                              child:
                                  Row(
                                children: [

                                  const Icon(
                                    Icons.circle,
                                    size: 8,
                                    color:
                                        Color(
                                      0xFF27AE60,
                                    ),
                                  ),

                                  const SizedBox(
                                      width: 8),

                                  Text(
                                    detalle[
                                        "estadoOperacion"],

                                    style:
                                        const TextStyle(
                                      color:
                                          Color(
                                        0xFF27AE60,
                                      ),

                                      fontWeight:
                                          FontWeight
                                              .w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                                height: 20),
                          ],
                        ),
                      ),
                    ),

                    // BOTÓN CERRAR
                    Padding(
                      padding:
                          const EdgeInsets
                              .fromLTRB(
                        20,
                        12,
                        20,
                        20,
                      ),

                      child:
                          SizedBox(
                        width:
                            double.infinity,

                        child:
                            ElevatedButton.icon(

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                              0xFF16233F,
                            ),

                            padding:
                                const EdgeInsets
                                    .symmetric(
                              vertical:
                                  14,
                            ),
                          ),

                          icon:
                              const Icon(
                            Icons.check,
                            color:
                                Colors.white,
                            size:
                                18,
                          ),

                          label:
                              const Text(
                            "Cerrar detalle",
                            style:
                                TextStyle(
                              color:
                                  Colors.white,
                            ),
                          ),

                          onPressed:
                              () =>
                                  Navigator.pop(
                            context,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },

      // ANIMACIÓN
      transitionBuilder:
          (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {

        final offsetAnimation =
            Tween<Offset>(
          begin:
              const Offset(
            1,
            0,
          ),
          end:
              Offset.zero,
        ).animate(
          CurvedAnimation(
            parent:
                animation,
            curve:
                Curves.easeOut,
          ),
        );

        return SlideTransition(
          position:
              offsetAnimation,
          child:
              child,
        );
      },
    );
  }

  // ============================================================
  // ETIQUETA DE SECCIÓN
  // ============================================================

  Widget _etiquetaSeccion(
    String texto,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 6,
      ),

      child:
          Text(
        texto,

        style:
            const TextStyle(
          color:
              Colors.grey,

          fontSize:
              11,

          fontWeight:
              FontWeight.w600,

          letterSpacing:
              0.5,
        ),
      ),
    );
  }

  // ============================================================
  // CAJA DE VALOR
  // ============================================================

  Widget _cajaValor(
    String etiqueta,
    String valor, {
    required bool tachado,
  }) {

    return Container(
      padding:
          const EdgeInsets.all(
        10,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(
          0xFFF4F6F9,
        ),

        borderRadius:
            BorderRadius.circular(
          10,
        ),
      ),

      child:
          Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            etiqueta,

            style:
                const TextStyle(
              fontSize:
                  10,

              color:
                  Colors.grey,
            ),
          ),

          const SizedBox(
              height: 4),

          Text(
            valor,

            style:
                TextStyle(
              fontWeight:
                  FontWeight.bold,

              decoration:
                  tachado
                      ? TextDecoration
                          .lineThrough
                      : TextDecoration
                          .none,

              color:
                  tachado
                      ? Colors.grey
                      : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INICIALES
  // ============================================================

  String _iniciales(
    String nombre,
  ) {

    List<String> partes =
        nombre.trim().split(" ");

    if (partes.length >= 2) {

      return partes[0][0] +
          partes[1][0];
    }

    return partes[0][0];
  }
}
