import 'package:flutter/material.dart';
//import 'DashboardScreen.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFF0F1B3D),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Logo
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.bar_chart, color: Colors.orange, size: 36),
            ), // Container
   
            const SizedBox(height: 16),
            const Text(
              "PASTELERÍA SOTO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 4),
            const Text(
              "Dulces momentos, calidad siempre",
              style: TextStyle(color: Colors.white70, fontSize: 21,fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),

            // Campo Usuario
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Usuario", style: TextStyle(color: Colors.white,fontSize:15 )),
            ),
            const SizedBox(height: 6),
            Container(
              color: Colors.white,
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: "Ingresa tu usuario",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ), // Container

            const SizedBox(height: 16),
            // Campo Contraseña
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Contraseña", style: TextStyle(color: Colors.white,fontSize:15)),
            ),
            const SizedBox(height: 6),
            Container(
              color: Colors.white,
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: Icon(Icons.visibility_off),
                  hintText: "Ingresa tu contraseña",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ), // Container

            const SizedBox(height: 12),
            // Recordarme / Olvidaste tu contraseña
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                
                Row(
                  children: [
                    Icon(Icons.check_box_outline_blank, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text("Recordarme", style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
                Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(color: Colors.orange, fontSize: 14),
                ),
              ],
            ), // Row

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // navegacionnn
                  //Navigator.push( context, MaterialPageRoute( builder: (context) => const Home_Screen(), ), );
                },
                child: const Text(
                  "Iniciar Sesión",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                     fontSize: 16,
                  ),
                ),
              ),
            ), // SizedBox
          ],
        ),
      ), // body Container
    );
  }
}