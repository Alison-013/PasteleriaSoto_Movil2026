
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/auth_provider.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login_Screen> {
  // Controladores para obtener lo que escribe el usuario
  final TextEditingController usuarioController = TextEditingController(); 
  final TextEditingController contrasenaController = TextEditingController();
  final _globalKey = GlobalKey<FormState>(); 

  // Para mostrar/ocultar contraseña
  bool mostrarContrasena = false;
  // Para mostrar mensaje de error
  String? mensajeError;

  Future<void> iniciarSesion() async {
    if (!_globalKey.currentState!.validate()) return;

    String usuario = usuarioController.text.trim();
    String contrasena = contrasenaController.text.trim();

    await context.read<AuthProvider>().login(userName: usuario, password: contrasena);
  } 

  @override
  void dispose() {
    usuarioController.dispose();
    contrasenaController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFF0F1B3D),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height,
           child: Form(                     
           key: _globalKey, 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.orange,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: Colors.orange,
                    size: 36,
                  ),
                ),

                const SizedBox(height: 16),

                // NOMBRE
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

                // DESCRIPCIÓN
                const Text(
                  "Dulces momentos, calidad siempre",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 40),

                // CAMPO USUARIO
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Usuario",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: usuarioController,

                    onChanged: (value) {
                      setState(() {
                        mensajeError = null;
                      });
                    },

                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Ingresa tu usuario",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(14),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                      return 'Ingresa tu usuario';
                      }
                    return null;
                    }

                  ),
    
                ),

                const SizedBox(height: 16),

                // CAMPO CONTRASEÑA
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Contraseña",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  color: Colors.white,
                  child: TextFormField(
                    controller: contrasenaController,
                    obscureText: !mostrarContrasena,

                    onChanged: (value) {
                      setState(() {
                        mensajeError = null;
                      });
                    },

                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                    
                      suffixIcon: IconButton(
                        icon: Icon(
                          mostrarContrasena
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),

                        onPressed: () {
                          setState(() {
                            mostrarContrasena =
                                !mostrarContrasena;
                          });
                        },
                      ),

                      hintText: "Ingresa tu contraseña",

                      border: InputBorder.none,

                      contentPadding:
                          const EdgeInsets.all(14),
                    ),

                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                       return 'Ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),
                ),

                // MENSAJE DE ERROR
                if (mensajeError != null) ...[
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerLeft,

                    child: Text(
                      mensajeError!,

                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 12),

                // RECORDARME / OLVIDASTE
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                          size: 14,
                        ),

                        SizedBox(width: 6),

                        Text(
                          "Recordarme",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                if (auth.errorMessage != null)...[
                  const SizedBox (height:20),
                  Text(auth.errorMessage!,
                  style: const TextStyle (color: Colors.red),),
                ],


                const SizedBox(height: 24),

                // BOTÓN INICIAR SESIÓN
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),

                  onPressed: auth.isSubmitting ? null : iniciarSesion,

                    child: auth.isSubmitting
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            "Iniciar Sesión",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
