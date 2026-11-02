
const Map<String, String> imagenPorCategoria = {
  'cupcake': 'assets/images_products/cupcake.jpg',
  'pasteles': 'assets/images_products/pastel.jpg',
  'bebidas': 'assets/images_products/bebida.jpg',
  'postres': 'assets/images_products/postre.jpg',
  'bocadillos': 'assets/images_products/bocadillo.jpg',
  'galletas': 'assets/images_products/galleta.jpg',
  'caramelos': 'assets/images_products/caramelo.jpg',
};


const Map<String, String> imagenPorPalabra = {
  'croissant': 'assets/images_products/croissant.jpg',
  'croasan': 'assets/images_products/croissant.jpg',
};

String imagenPara({required String categoria, required String nombre}) {
  final n = nombre.toLowerCase();
  for (final entrada in imagenPorPalabra.entries) {
    if (n.contains(entrada.key)) return entrada.value;
  }
  return imagenPorCategoria[categoria.toLowerCase()] ?? '';
}