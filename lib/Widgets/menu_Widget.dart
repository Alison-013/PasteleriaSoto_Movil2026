import 'package:flutter/material.dart';
 
// Widget del menu de abajo. Se manda a llamar desde cada pantalla
// (Inicio, Inventario, Ventas, Actividad, Mas)
class menu_Widget extends StatelessWidget {
 
  final int currentIndex; // dice cual tab esta activo (0, 1, 2, 3 o 4)
  final Function(int) onTap; // que pasa cuando el usuario toca un tab

  const menu_Widget({
   super.key,
   required this.currentIndex,
   required this.onTap,
  });
  

   @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFECEFF3), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(icon: Icons.home_outlined, label: "Inicio", index: 0),
          _item(icon: Icons.inventory_2_outlined, label: "Inventario", index: 1),
          _item(icon: Icons.receipt_long_outlined, label: "Ventas", index: 2),
          _item(icon: Icons.access_time_outlined, label: "Actividad", index: 3),
          _item(icon: Icons.more_horiz, label: "Más", index: 4),
        ],
      ), // Row
    ); // Container
  }

  Widget _item({
    required IconData icon,
    required String label,
    required int index,
  }) 

  {
    bool isActive = currentIndex == index;
 
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFEAF2FE) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
 
            Icon(
              icon,
              size: 22,
              color: isActive ? const Color(0xFF2E6BF2) : const Color(0xFFA6ACB8),
            ),
 
            const SizedBox(height: 2),
 
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? const Color(0xFF2E6BF2) : const Color(0xFFA6ACB8),
              ),
            ),
 
          ],
        ), // Column
      ), // Container
    ); // GestureDetector
  }
}
 


