// 42500 -> $42,500.00
String formatearMonto(double valor) {
  final partes = valor.abs().toStringAsFixed(2).split('.');
  final entero = partes[0].replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (m) => ',',
  );
  final signo = valor < 0 ? '-' : '';
  return '$signo\$$entero.${partes[1]}';
}
 
// 2026-06-26 -> 26/06/2026
String formatearFecha(DateTime fecha) {
  final dia = fecha.day.toString().padLeft(2, '0');
  final mes = fecha.month.toString().padLeft(2, '0');
  return '$dia/$mes/${fecha.year}';
}