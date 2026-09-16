import 'package:flutter/material.dart';
import '/Widgets/menu_Widget.dart';
import '/Widgets/TopBar_Widget.dart';
 
class ActividadScreen extends StatefulWidget {
  const ActividadScreen({super.key});
 
  @override
  State<ActividadScreen> createState() => _ActividadScreenState();
}

 
class _ActividadScreenState extends State<ActividadScreen> {

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
    body:SingleChildScrollView()); 
  }
}
     