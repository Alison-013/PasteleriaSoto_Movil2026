import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/data/models/cliente_model.dart';

const List<Color> _coloresAvatar = [
  Color(0xFF779A9A),
  Color(0xFF587889),
  Color(0xFFB88F79),
  Color(0xFF9C806E),
  Color(0xFF8F7777),
  Color(0xFF678478),
  Color(0xFF9A829A),
  Color(0xFF728A9E),
];

// Iniciales: "Juan Perez" -> JP
String inicialesCliente(String nombre) {
  final partes = nombre.trim().split(' ').where((p) => p.isNotEmpty).toList();

  if (partes.isEmpty) return '?';
  if (partes.length == 1) {
    final p = partes.first;
    return (p.length >= 2 ? p.substring(0, 2) : p).toUpperCase();
  }
  return '${partes[0][0]}${partes[1][0]}'.toUpperCase();
}

class AvatarCliente extends StatelessWidget {
  final CustomerModel cliente;
  final double tamano;

  const AvatarCliente({
    super.key,
    required this.cliente,
    this.tamano = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamano,
      height: tamano,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: _coloresAvatar[cliente.customerId % _coloresAvatar.length],
        shape: BoxShape.circle,
      ),
      child: Text(
        inicialesCliente(cliente.customerName),
        style: TextStyle(
          color: Colors.white,
          fontSize: tamano * 0.34,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}