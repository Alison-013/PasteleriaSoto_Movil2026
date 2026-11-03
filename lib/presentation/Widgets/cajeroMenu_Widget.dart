import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';

class cajeroMenu_Widget extends StatelessWidget {

  final int currentIndex; // cual tab esta activo

  const cajeroMenu_Widget({
    super.key,
    required this.currentIndex,
  });

  // Decide a que pantalla ir segun el tab que se toco
  void _navegar(BuildContext context, int index) {

    if (currentIndex == index) return; // no hace nada pq ya estamos ahi 

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed(AppRoutes.inventarioCajero);
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed(AppRoutes.reportesCajero);
        break;
      case 2:
       Navigator.of(context).pushReplacementNamed(AppRoutes.perfilCajero);
        break;
     
    }
  }

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
          _item(context, icon: Icons.inventory_2_outlined, label: "Inventario", index: 0),
          _item(context, icon: Icons.point_of_sale_outlined, label: "Ventas", index: 1),
          _item(context, icon: Icons.person_outlined, label: "Mi Perfil", index: 2),
        ],
      ), // Row
    ); // Container
  }

  Widget _item(BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
  }) {

    bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => _navegar(context, index), // ahora llama a _navegar, no a un onTap de afuera
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