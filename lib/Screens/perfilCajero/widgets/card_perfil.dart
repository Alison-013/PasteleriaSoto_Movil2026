import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TarjetaPerfil extends StatelessWidget {
  const TarjetaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 20, 14, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 9,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
             ClipRRect( 
              borderRadius: BorderRadius.circular(10), 
              child: Image.network( 'https://picsum.dev/images/ai/people/people-pghappw0hnwj.jpg',
              width: 92, height: 92, 
              fit: BoxFit.cover, ), ),
              
              Positioned(
                right: -5,
                bottom: -4,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF062B3A),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Administrador Principal',
            style: GoogleFonts.playfairDisplay(
              fontSize: 14,
              color: const Color(0xFF092535),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'admin@pasteleriasoto.com',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF41484D),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFD5EAFE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.shield_outlined,
                  size: 11,
                  color: Color(0xFF092535),
                ),
                const SizedBox(width: 3),
                Text(
                  'Rol: Super Admin',
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    color: const Color(0xFF092535),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}