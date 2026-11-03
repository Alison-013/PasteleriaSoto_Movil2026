import 'package:flutter/material.dart';

class BuscadorClientes extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const BuscadorClientes({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E4EA)),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: "Buscar por nombre, teléfono...",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}