import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/data/models/audit_log_model.dart';

const Map<String, String> _nombresRecurso = {
  'auth': 'Autenticación',
  'products': 'Productos',
  'inventory': 'Inventario',
  'sales': 'Ventas',
  'customers': 'Clientes',
  'suppliers': 'Proveedores',
  'categories': 'Categorías',
  'purchases': 'Compras',
  'invoices': 'Facturas',
  'orders': 'Pedidos',
  'users': 'Usuarios',
  'auditlogs': 'Registros del sistema',
  'personalizedproducts': 'Productos personalizados',
  'options': 'Opciones',
};

const List<String> _meses = [
  'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
  'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
];

String _recurso(String path) {
  final partes = path.toLowerCase().split('/').where((p) => p.isNotEmpty).toList();
  final i = partes.indexOf('api');
  final clave = (i >= 0 && i + 1 < partes.length) ? partes[i + 1] : '';

  if (clave == 'auth' && partes.contains('me')) return 'Perfil del usuario';
  if (clave.isEmpty) return path;
  return _nombresRecurso[clave] ?? (clave[0].toUpperCase() + clave.substring(1));
}

String _hora24(DateTime f) =>
    '${f.hour.toString().padLeft(2, '0')}:${f.minute.toString().padLeft(2, '0')}';

String _fechaHoraLarga(DateTime f) {
  final hora12 = f.hour % 12 == 0 ? 12 : f.hour % 12;
  final ampm = f.hour >= 12 ? 'PM' : 'AM';
  return '${f.day.toString().padLeft(2, '0')} ${_meses[f.month - 1]} ${f.year} - '
      '${hora12.toString().padLeft(2, '0')}:${f.minute.toString().padLeft(2, '0')} $ampm';
}

String _estadoOperacion(int codigo) {
  if (codigo >= 200 && codigo < 300) return 'Completada ($codigo)';
  if (codigo == 401) return 'No autorizada ($codigo)';
  if (codigo == 403) return 'Acceso denegado ($codigo)';
  if (codigo >= 400 && codigo < 500) return 'Rechazada ($codigo)';
  if (codigo >= 500) return 'Error del servidor ($codigo)';
  return 'Código $codigo';
}

List<Map<String, dynamic>> actividadesDesdeLogs(List<AuditLogModel> logs) {
  return logs.map((log) {
    final recurso = _recurso(log.path);
    final metodo = log.method.toUpperCase();
    final esLogin = metodo == 'POST' && log.path.toLowerCase().endsWith('/auth');
    final fallo = log.statusCode >= 400;

    String tipo;
    Color tagColor;
    IconData icono;
    Color iconoColor;
    Color iconoBg;
    String tituloNormal;
    String tituloBold = recurso;

    if (fallo) {
      tipo = 'Error';
      tagColor = const Color(0xFF8E44AD);
      icono = Icons.warning_amber_rounded;
      iconoColor = const Color(0xFF8E44AD);
      iconoBg = const Color(0xFFF3E8F9);
      tituloNormal = 'Petición fallida en: ';
    } else if (esLogin) {
      tipo = 'Acceso';
      tagColor = const Color(0xFF16233F);
      icono = Icons.login;
      iconoColor = Colors.white;
      iconoBg = const Color(0xFF16233F);
      tituloNormal = 'Nuevo inicio de sesión ';
      tituloBold = 'exitoso';
    } else if (metodo == 'POST') {
      tipo = 'Creación';
      tagColor = const Color(0xFF27AE60);
      icono = Icons.add_circle_outline;
      iconoColor = const Color(0xFF27AE60);
      iconoBg = const Color(0xFFE8F8EF);
      tituloNormal = 'Se creó un registro en: ';
    } else if (metodo == 'PUT' || metodo == 'PATCH') {
      tipo = 'Edición';
      tagColor = const Color(0xFFF2994A);
      icono = Icons.edit_outlined;
      iconoColor = const Color(0xFF2E6BF2);
      iconoBg = const Color(0xFFEAF2FE);
      tituloNormal = 'Se modificó un registro en: ';
    } else if (metodo == 'DELETE') {
      tipo = 'Eliminación';
      tagColor = const Color(0xFFEB5757);
      icono = Icons.delete_outline;
      iconoColor = const Color(0xFFEB5757);
      iconoBg = const Color(0xFFFDEDED);
      tituloNormal = 'Se eliminó un registro en: ';
    } else {
      tipo = 'Consulta';
      tagColor = const Color(0xFF526167);
      icono = Icons.visibility_outlined;
      iconoColor = const Color(0xFF526167);
      iconoColor = const Color(0xFF0F1B3D);
      iconoBg = const Color(0xFFE8ECF5);
      tituloNormal = 'Consulta realizada en: ';
    }

    final resumen = '$metodo ${log.path} · ${log.statusCode} · ${log.elapsedMilliseconds} ms';

    return {
      'fecha': log.timestamp,
      'tipo': tipo,
      'tagColor': tagColor,
      'icono': icono,
      'iconoColor': iconoColor,
      'iconoBg': iconoBg,
      'hora': _hora24(log.timestamp),
      'usuarioCorto': 'sin usuario',
      'tituloNormal': tituloNormal,
      'tituloBold': tituloBold,
      'descripcion': resumen,
      'detalle': {
        'fechaHora': _fechaHoraLarga(log.timestamp),
        'usuarioNombre': 'Usuario no registrado',
        'usuarioEmail': 'El registro del servidor no guarda el usuario',
        'productoNombre': recurso,
        'productoSku': '$metodo ${log.path}',
        'productoCategoria': 'Nivel: ${log.level} • ${log.elapsedMilliseconds} ms',
        'descripcionLarga':
            'La petición $metodo a ${log.path} terminó con código ${log.statusCode} '
            'en ${log.elapsedMilliseconds} ms. Traza: ${log.traceId}.',
        'valorAnterior': null,
        'valorNuevo': null,
        'estadoOperacion': _estadoOperacion(log.statusCode),
      },
    };
  }).toList();
}