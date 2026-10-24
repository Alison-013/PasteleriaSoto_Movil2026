import 'package:flutter/material.dart';

/// Una opción dentro de un filtro desplegable (ej: "Disponible", "Pastelería").
class FiltroOpcion {
  final String label;
  final Color color;
  const FiltroOpcion({required this.label, this.color = const Color(0xFF16233F)});
}

/// Botón de filtro que, al tocarlo, abre una hoja inferior con buscador
/// y la lista de opciones. Se reutiliza tanto para el filtro de Categoría
/// como para el de Stock, pasando opciones distintas a cada instancia.
class FiltroDropdownWidget extends StatelessWidget {
  final String titulo; // Ej: "Categoría" o "Stock"
  final List<FiltroOpcion> opciones; // Debe incluir "Todos" como primera opción
  final String seleccionado;
  final ValueChanged<String> onSeleccionar;

  const FiltroDropdownWidget({
    super.key,
    required this.titulo,
    required this.opciones,
    required this.seleccionado,
    required this.onSeleccionar,
  });

  Color get _colorActual {
    if (seleccionado == "Todos") return const Color(0xFF16233F);
    final opcion = opciones.firstWhere(
      (o) => o.label == seleccionado,
      orElse: () => const FiltroOpcion(label: "Todos"),
    );
    return opcion.color;
  }

  void _abrirSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _SelectorFiltro(
          titulo: titulo,
          opciones: opciones,
          seleccionado: seleccionado,
          onSeleccionar: (valor) {
            onSeleccionar(valor);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activo = seleccionado != "Todos";
    final color = _colorActual;

    return GestureDetector(
      onTap: () => _abrirSelector(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: activo ? color : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: activo ? color : const Color(0xFFE0E4EA)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              activo ? seleccionado : titulo,
              style: TextStyle(
                color: activo ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: activo ? Colors.white : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

/// Contenido de la hoja inferior: buscador + lista de opciones filtrada.
class _SelectorFiltro extends StatefulWidget {
  final String titulo;
  final List<FiltroOpcion> opciones;
  final String seleccionado;
  final ValueChanged<String> onSeleccionar;

  const _SelectorFiltro({
    required this.titulo,
    required this.opciones,
    required this.seleccionado,
    required this.onSeleccionar,
  });

  @override
  State<_SelectorFiltro> createState() => _SelectorFiltroState();
}

class _SelectorFiltroState extends State<_SelectorFiltro> {
  String _busqueda = "";

  @override
  Widget build(BuildContext context) {
    final opcionesFiltradas = widget.opciones
        .where((o) => o.label.toLowerCase().contains(_busqueda.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Filtrar por ${widget.titulo}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          // Buscador dentro del filtro
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              onChanged: (valor) => setState(() => _busqueda = valor),
              decoration: InputDecoration(
                icon: const Icon(Icons.search, color: Colors.grey),
                hintText: "Buscar ${widget.titulo.toLowerCase()}...",
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 8),

          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 320),
            child: opcionesFiltradas.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text("Sin resultados", style: TextStyle(color: Colors.grey)),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: opcionesFiltradas.length,
                    itemBuilder: (context, index) {
                      final opcion = opcionesFiltradas[index];
                      final activo = opcion.label == widget.seleccionado;
                      return ListTile(
                        onTap: () => widget.onSeleccionar(opcion.label),
                        leading: CircleAvatar(
                          radius: 6,
                          backgroundColor: opcion.label == "Todos"
                              ? const Color(0xFF16233F)
                              : opcion.color,
                        ),
                        title: Text(
                          opcion.label,
                          style: TextStyle(
                            fontWeight: activo ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        trailing: activo
                            ? const Icon(Icons.check, color: Color(0xFF16233F))
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}