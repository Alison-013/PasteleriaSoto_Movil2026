import 'package:flutter/material.dart';

// Widget de la barra de arriba, con el nombre de la pasteleria
// y el avatar del usuario.
class TopBar_Widget extends StatelessWidget {

  const TopBar_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF0F1B3D),
       
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          const Text(
            "Pastelería Soto",
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Avatar del usuario (circulo). Por ahora un icono,
          // despues lo puedes cambiar por una foto real con NetworkImage.
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, color: Color(0xFF0F1B3D)),
          ),

        ],
      ), // Row
    ); // Container
  }
}