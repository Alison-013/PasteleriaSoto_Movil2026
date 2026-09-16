import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';
 
class Activity_Screen extends StatefulWidget {
  const Activity_Screen({super.key});
 
  @override
  State<Activity_Screen> createState() => _ActividadScreenState();
}

 
class _ActividadScreenState extends State<Activity_Screen> {
  
  int _currentIndex = 3; // "Actividad" es el tab activo al darle click
 
  String _filtroActivo = "Por Día";
  final List<String> _filtros = ["Por Día", "Semanal", "Por Mes", "Anual"];
 
  // Lista de actividades cada una trae todo lo que necesita
  // tanto la tarjeta pepquueña como el detalle grande.
  final List<Map<String, dynamic>> _actividades = [
    {
      "tipo": "Edición",
      "tagColor": const Color(0xFFF2994A),
      "icono": Icons.edit_outlined,
      "iconoColor": const Color(0xFF2E6BF2),
      "iconoBg": const Color(0xFFEAF2FE),
      "hora": "14:32",
      "usuarioCorto": "maria.g",
      "tituloNormal": "María Gómez editó el producto: ",
      "tituloBold": "Pastel de Trufa",
      "descripcion": "Se actualizó el precio de \$45.00 a \$48.00 y se modificó la descripción.",
      "detalle": {
        "fechaHora": "24 Octubre 2023 - 02:32 PM",
        "usuarioNombre": "María Gómez",
        "usuarioEmail": "maria.g • Cajero / Tienda",
        "productoNombre": "Pastel de Trufa",
        "productoSku": "PST-TRF-081",
        "productoCategoria": "Repostería",
        "descripcionLarga": "Se actualizó el precio de \$45.00 a \$48.00 y se modificó la descripción del producto para el catálogo del día.",
        "valorAnterior": "\$45.00",
        "valorNuevo": "\$48.00",
        "estadoOperacion": "Modificación guardada",
      },
    },
    {
      "tipo": "Eliminación",
      "tagColor": const Color(0xFFEB5757),
      "icono": Icons.delete_outline,
      "iconoColor": const Color(0xFFEB5757),
      "iconoBg": const Color(0xFFFDEDED),
      "hora": "11:15",
      "usuarioCorto": "carlos.s",
      "tituloNormal": "Admin eliminó el usuario: ",
      "tituloBold": "Juan Pérez",
      "descripcion": "Usuario inactivo eliminado del sistema.",
      "detalle": {
        "fechaHora": "24 Octubre 2023 - 11:15 AM",
        "usuarioNombre": "Carlos Soto",
        "usuarioEmail": "carlos.s • Administrador",
        "productoNombre": "Juan Pérez",
        "productoSku": "Usuario del sistema",
        "productoCategoria": "Cuenta",
        "descripcionLarga": "Usuario inactivo eliminado del sistema por falta de uso durante más de 6 meses.",
        "valorAnterior": null,
        "valorNuevo": null,
        "estadoOperacion": "Eliminación completada",
      },
    },
    {
      "tipo": "Acceso",
      "tagColor": const Color(0xFF16233F),
      "icono": Icons.login,
      "iconoColor": Colors.white,
      "iconoBg": const Color(0xFF16233F),
      "hora": "08:05",
      "usuarioCorto": "admin.principal",
      "tituloNormal": "Nuevo inicio de sesión ",
      "tituloBold": "exitoso",
      "descripcion": "Inicio de sesión desde IP: 192.168.1.45 (Dispositivo móvil).",
      "detalle": {
        "fechaHora": "24 Octubre 2023 - 08:05 AM",
        "usuarioNombre": "Admin Principal",
        "usuarioEmail": "admin.principal • Administrador",
        "productoNombre": "Inicio de sesión",
        "productoSku": "IP: 192.168.1.45",
        "productoCategoria": "Dispositivo móvil",
        "descripcionLarga": "Inicio de sesión exitoso desde un dispositivo móvil registrado previamente.",
        "valorAnterior": null,
        "valorNuevo": null,
        "estadoOperacion": "Acceso concedido",
      },
    },
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
    body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
 
            const TopBar_Widget(), // barra de arriba reutilizable
 
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
 
                  const Text(
                    "Registros del Sistema",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Historial cronológico de actividades administrativas.",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
 
                  const SizedBox(height: 16),
 
                  // Buscador
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0E4EA)),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Buscar registros...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ), // Container buscador
 
                  const SizedBox(height: 16),
 
                  // Filtros (Por Día, Semanal, Por Mes, Anual)
                  SizedBox(
                    height: 40,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: _filtros.map((filtro) {
                          bool activo = _filtroActivo == filtro;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _filtroActivo = filtro;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: activo ? const Color(0xFF16233F) : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: activo ? const Color(0xFF16233F) : const Color(0xFFE0E4EA),
                                  ),
                                ),
                                child: Text(
                                  filtro,
                                  style: TextStyle(
                                    color: activo ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ), // filtros
 
                  const SizedBox(height: 16),
 
                  const Center(
                    child: Text(
                      "HOY, 24 OCTUBRE 2023",
                      style: TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 0.5),
                    ),
                  ),
 
                  const SizedBox(height: 12),
 
                  // Lista de tarjetas de actividad
                  Column(
                    children: _actividades.map((actividad) {
                      return GestureDetector(
                        onTap: () => _mostrarDetalle(context, actividad),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFEFF1F5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
 
                              // Icono circular de color segun el tipo
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: actividad["iconoBg"],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(actividad["icono"], size: 18, color: actividad["iconoColor"]),
                              ),
 
                              const SizedBox(width: 12),
 
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
 
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(color: Colors.black87, fontSize: 14),
                                        children: [
                                          TextSpan(text: actividad["tituloNormal"]),
                                          TextSpan(
                                            text: actividad["tituloBold"],
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ), // RichText
 
                                    const SizedBox(height: 2),
                                    Text(actividad["hora"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
 
                                    const SizedBox(height: 6),
                                    Text(actividad["descripcion"], style: const TextStyle(color: Colors.black54, fontSize: 13)),
 
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: (actividad["tagColor"] as Color).withOpacity(0.12),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            actividad["tipo"],
                                            style: TextStyle(
                                              color: actividad["tagColor"],
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(Icons.person_outline, size: 14, color: Colors.grey.shade500),
                                        const SizedBox(width: 2),
                                        Text(actividad["usuarioCorto"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                      ],
                                    ),
 
                                  ],
                                ),
                              ), // Expanded
 
                              const Icon(Icons.chevron_right, color: Colors.grey),
 
                            ],
                          ), // Row tarjeta
                        ), // Container tarjeta
                      ); // GestureDetector
                    }).toList(),
                  ), // Column lista
 
                  const SizedBox(height: 12),
 
                  // Paginacion (visual)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Página 1 de 3", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 12),
                      const Icon(Icons.chevron_left, color: Colors.grey),
                      const SizedBox(width: 8),
                      _numeroPagina(1, activo: true),
                      const SizedBox(width: 8),
                      _numeroPagina(2, activo: false),
                      const SizedBox(width: 8),
                      _numeroPagina(3, activo: false),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right, color: Colors.grey),
                    ],
                  ),
 
                ],
              ),
            ), // Padding contenido
 
          ],
        ), // Column general
      ), // SingleChildScrollView
      bottomNavigationBar: menu_Widget(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // aqui despues iria la navegacion a cada pantalla pero hay que esperar a crearlass
        },
      ),
    );
  }
 
  // Circulo numerado para la paginacion
  Widget _numeroPagina(int numero, {required bool activo}) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: activo ? const Color(0xFF16233F) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE0E4EA)),
      ),
      child: Text(
        "$numero",
        style: TextStyle(color: activo ? Colors.white : Colors.black87),
      ),
    );
  }
 
 
  // Muestra el detalle,
  void _mostrarDetalle(BuildContext context, Map<String, dynamic> actividad) {
    final detalle = actividad["detalle"];
 
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // se puede cerrar tocando
      barrierLabel: "Cerrar detalle",
      barrierColor: Colors.black.withOpacity(0.4), // fondo oscuro detras 
      transitionDuration: const Duration(milliseconds: 250),
 
      // usamos Align para pegarlo a la derecha
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.white,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85, // 85% de pantslla
              height: double.infinity, // ocupa de arriba hacia abajo completo
              child: SafeArea(
                child: Column(
                  children: [
 
                    // Encabezadono hace scroll se queda fijo arriba
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 16, 12, 16),
                      color: const Color(0xFFF4F6F9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(actividad["icono"], color: actividad["iconoColor"] == Colors.white ? Colors.black : actividad["iconoColor"]),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text("Detalle de actividad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          Text(
                            actividad["tipo"],
                            style: TextStyle(color: actividad["tagColor"], fontWeight: FontWeight.w600, fontSize: 12),
                          ),
                        ],
                      ),
                    ), // Container 

                    // Esta parte si hace scroll
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
 
                        _etiquetaSeccion("FECHA Y HORA"),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(detalle["fechaHora"], style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ), // Container fecha
                        const SizedBox(height: 16),
 
                        _etiquetaSeccion("USUARIO RESPONSABLE"),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFEAF2FE),
                                child: Text(
                                  _iniciales(detalle["usuarioNombre"]),
                                  style: const TextStyle(color: Color(0xFF2E6BF2), fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detalle["usuarioNombre"], style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(detalle["usuarioEmail"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ), // Container usuario
                        const SizedBox(height: 16),
 
                        _etiquetaSeccion("DETALLE AFECTADO"),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(detalle["productoNombre"], style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text(detalle["productoSku"], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(detalle["productoCategoria"], style: const TextStyle(fontSize: 12)),
                              ),
                            ],
                          ),
                        ), // Container producto
                        const SizedBox(height: 16),
 
                        _etiquetaSeccion("DESCRIPCIÓN DE LA ACCIÓN"),
                        Text(detalle["descripcionLarga"], style: const TextStyle(fontSize: 13)),
                        const SizedBox(height: 16),
 
                        // si la actividad tiene esos datos si enseña algo, si no, no
                        if (detalle["valorAnterior"] != null) ...[
                          _etiquetaSeccion("COMPARATIVA DE VALORES"),
                          Row(
                            children: [
                              Expanded(child: _cajaValor("VALOR ANTERIOR", detalle["valorAnterior"], tachado: true)),
                              const SizedBox(width: 10),
                              Expanded(child: _cajaValor("VALOR ACTUALIZADO", detalle["valorNuevo"], tachado: false)),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
 
                        _etiquetaSeccion("ESTADO DE OPERACIÓN"),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE9F9EF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.circle, size: 8, color: Color(0xFF27AE60)),
                              const SizedBox(width: 8),
                              Text(detalle["estadoOperacion"], style: const TextStyle(color: Color(0xFF27AE60), fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
 
                        const SizedBox(height: 20),
 
                      ],
                        ),
                      ),
                    ),
                    // Esta parte nohace scroll, se queda fija abajo siempre es del botom
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF16233F),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.check, color: Colors.white, size: 18),
                          label: const Text("Cerrar detalle", style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context),
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
 
      // Esto desliza detalle
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0), // empieza derecha a izquierda
          end: Offset.zero, // termina en su lugar
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)); 
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
 
  Widget _etiquetaSeccion(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        texto,
        style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    );
  }
 
  Widget _cajaValor(String etiqueta, String valor, {required bool tachado}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(etiqueta, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(
            valor,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: tachado ? TextDecoration.lineThrough : TextDecoration.none,
              color: tachado ? Colors.grey : Colors.black87,
            ),
          ),
        ],
    )); 
  }


  String _iniciales(String nombre) {
    List<String> partes = nombre.trim().split(" ");
    if (partes.length >= 2) {
      return partes[0][0] + partes[1][0];
    }
    return partes[0][0];
  }
}

     
