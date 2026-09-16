import 'package:flutter/material.dart';

// Widget del menu de abajo para el rol CAJERO.
class cajeroMenu_Widget extends StatelessWidget {

  final int currentIndex; // dice cual tab esta activo (0, 1, 2 )
  final Function(int) onTap; // que pasa cuando el usuario toca un tab

  const cajeroMenu_Widget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFECEFF3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(icon: Icons.cake_outlined, label: "Productos", index: 0),
          _item(icon: Icons.receipt_long_outlined, label: "Ventas", index: 1),
          _item(icon: Icons.person, label: "Mi Perfil", index: 2),
        ],
      ), // Row
    ); // Container
  }

  Widget _item({
    required IconData icon,
    required String label,
    required int index,
  }) {

    bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFDCE9FE) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Icon(
              icon,
              size: 24,
              color: isActive ? const Color(0xFF2E6BF2) : const Color(0xFF6B7280),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? const Color(0xFF2E6BF2) : const Color(0xFF6B7280),
              ),
            ),

          ],
        ), // Column
      ), // Container
    ); // GestureDetector
  }
}