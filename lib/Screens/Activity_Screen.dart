import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';
 
class ActividadScreen extends StatefulWidget {
  const ActividadScreen({super.key});
 
  @override
  State<ActividadScreen> createState() => _ActividadScreenState();
}

 
class _ActividadScreenState extends State<ActividadScreen> {
  
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
    body:SingleChildScrollView()); 
  }
}
     