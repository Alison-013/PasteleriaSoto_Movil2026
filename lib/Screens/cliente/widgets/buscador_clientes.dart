import 'package:flutter/material.dart';

class BuscadorClientes extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const BuscadorClientes({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const colorPrincipal = Color(0xFF062B3A);
    const colorBorde = Color(0xFFD5DADF);
    const colorFondo = Color(0xFFF8F7F7);

    return TextField(
      onChanged: onChanged,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: 'Buscar cliente por...',
        hintStyle: const TextStyle(
          color: Color(0xFF697178),
          fontSize: 12,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 18,
          color: Color(0xFF657078),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        filled: true,
        fillColor: colorFondo,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: colorBorde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: colorBorde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: colorPrincipal),
        ),
      ),
    );
  }
}