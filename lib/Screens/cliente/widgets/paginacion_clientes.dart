import 'package:flutter/material.dart';

class PaginadorClientes extends StatelessWidget {
  final int paginaActual;
  final int totalPaginas;
  final ValueChanged<int> onCambiarPagina;

  const PaginadorClientes({
    super.key,
    required this.paginaActual,
    required this.totalPaginas,
    required this.onCambiarPagina,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE3E5E7)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Página $paginaActual de $totalPaginas',
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF343A3E),
              ),
            ),
          ),
          _BotonPagina(
            icono: Icons.chevron_left,
            seleccionado: false,
            habilitado: paginaActual > 1,
            onTap: () {
              if (paginaActual > 1) {
                onCambiarPagina(paginaActual - 1);
              }
            },
          ),
          const SizedBox(width: 4),
          ...List.generate(totalPaginas, (index) {
            final numero = index + 1;

            return Padding(
              padding: const EdgeInsets.only(left: 4),
              child: _BotonPagina(
                texto: '$numero',
                seleccionado: paginaActual == numero,
                habilitado: true,
                onTap: () => onCambiarPagina(numero),
              ),
            );
          }),
          const SizedBox(width: 4),
          _BotonPagina(
            icono: Icons.chevron_right,
            seleccionado: false,
            habilitado: paginaActual < totalPaginas,
            onTap: () {
              if (paginaActual < totalPaginas) {
                onCambiarPagina(paginaActual + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _BotonPagina extends StatelessWidget {
  final String? texto;
  final IconData? icono;
  final bool seleccionado;
  final bool habilitado;
  final VoidCallback onTap;

  const _BotonPagina({
    this.texto,
    this.icono,
    required this.seleccionado,
    required this.habilitado,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: habilitado ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: seleccionado
              ? const Color(0xFF062B3A)
              : const Color(0xFFF1F1F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: texto != null
            ? Text(
                texto!,
                style: TextStyle(
                  fontSize: 9,
                  color: seleccionado
                      ? Colors.white
                      : const Color(0xFF555B60),
                ),
              )
            : Icon(
                icono,
                size: 15,
                color: habilitado
                    ? const Color(0xFF555B60)
                    : const Color(0xFFBFC3C6),
              ),
      ),
    );
  }
}