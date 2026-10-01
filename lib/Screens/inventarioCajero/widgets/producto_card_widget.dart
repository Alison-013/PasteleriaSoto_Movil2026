import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tarjeta de producto usada dentro de la lista de Inventario.

class ProductoCardWidget extends StatelessWidget {
  final String nombre;
  final String categoria;
  final String sku;
  final int uds;
  final String estado; // "Disponible" | "Bajo stock" | "Agotado"
  final String imagenUrl;

  const ProductoCardWidget({
    super.key,
    required this.nombre,
    required this.categoria,
    required this.sku,
    required this.uds,
    required this.estado,
    required this.imagenUrl,
  });

  Color _colorEstado(String estado) {
    if (estado == "Disponible") return const Color(0xFF27AE60);
    if (estado == "Bajo stock") return const Color(0xFFF2994A);
    return const Color(0xFFEB5757); // Agotado
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorEstado(estado);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEFF1F5)),
      ),
      child: Row(
        children: [
          // Imagen del producto (placeholder de prueba hasta tener fotos reales)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imagenUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  width: 56,
                  height: 56,
                  color: const Color(0xFFF4F6F9),
                  child: const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                // Si la imagen falla (sin internet, URL caída, etc.) se
                // muestra el ícono anterior en vez de dejar un espacio roto.
                return Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.cake_outlined,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  "$categoria • SKU: $sku",
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$uds uds",
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  estado,
                  style: GoogleFonts.playfairDisplay(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}