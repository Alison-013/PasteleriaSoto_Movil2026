
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuscadorProveedores extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const BuscadorProveedores({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFDCE3E7),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 16,
            color: Color(0xFF79909C),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF092535),
              ),
              decoration: InputDecoration(
                hintText: 'Buscar por nombre, código...',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF94A2A8),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
