import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pasteleria_26/app.routes.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/cliente_model.dart';
import 'package:flutter_pasteleria_26/presentation/Providers/cliente_provider.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/TopBar_Widget.dart';
import 'package:flutter_pasteleria_26/presentation/Widgets/menu_Widget.dart';
import 'widgets/buscador_clientes.dart';
import 'widgets/card_clientes.dart';
import 'widgets/detalle_cliente.dart';
import 'widgets/filtros_clientes.dart';
import 'widgets/paginacion_clientes.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final List<String> _filtros = const [
    'Todos',
    'Activos',
    'Inactivos',
  ];

  String _textoBusqueda = '';
  int _filtroActivo = 0;
  int _paginaActual = 1;
  final int _clientesPorPagina = 5;

  //filtro cliente
  List<CustomerModel> _filtrar(List<CustomerModel> clientes) {
    final busqueda = _textoBusqueda.trim().toLowerCase();

    return clientes.where((cliente) {
      // FILTRO POR ESTADO
      if (_filtroActivo == 1 && !cliente.isActive) return false;
      if (_filtroActivo == 2 && cliente.isActive) return false;

      // BUSCADOR
      if (busqueda.isEmpty) return true;

      return cliente.customerName.toLowerCase().contains(busqueda) ||
          cliente.phone.toLowerCase().contains(busqueda) ||
          cliente.cedula.toLowerCase().contains(busqueda) ||
          cliente.city.toLowerCase().contains(busqueda);
    }).toList();
  }

  int _totalPaginas(List<CustomerModel> filtrados) {
    final total = (filtrados.length / _clientesPorPagina).ceil();

    return total == 0 ? 1 : total;
  }

  @override
  Widget build(BuildContext context) {
    final customers = context.watch<CustomerProvider>();
    final filtrados = _filtrar(customers.customers);
    final totalPaginas = _totalPaginas(filtrados);
    final paginaActual =
        _paginaActual > totalPaginas ? totalPaginas : _paginaActual;

    final inicio = (paginaActual - 1) * _clientesPorPagina;

    final clientesDeLaPagina =
        filtrados.skip(inicio).take(_clientesPorPagina).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const TopBar_Widget(),

              Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // RUTA
                    GestureDetector(
                      onTap: () => Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.mas,
                      ),

                      child: Row(
                        children: const [
                          Text(
                            "Más Opciones",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          Icon(
                            Icons.chevron_right,
                            size: 16,
                            color: Colors.grey,
                          ),

                          Text(
                            "Clientes",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // TITULO
                    Row(
                      children: [
                        const Text(
                          "Clientes",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF1F5),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Text(
                            "${filtrados.length} total",
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      "Consulta de clientes registrados.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // BUSCADOR
                    BuscadorClientes(
                      onChanged: (texto) {
                        setState(() {
                          _textoBusqueda = texto;
                          _paginaActual = 1;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // ENCABEZADO
                    const Text(
                      "DIRECTORIO REGISTRADO",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // FILTROS
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(_filtros.length, (index) {
                        return FiltroClienteChip(
                          texto: _filtros[index],
                          seleccionado: _filtroActivo == index,
                          onTap: () {
                            setState(() {
                              _filtroActivo = index;
                              _paginaActual = 1;
                            });
                          },
                        );
                      }),
                    ),

                    const SizedBox(height: 16),

                    // LISTA DE CLIENTES
                    if (customers.viewStatus == ViewStatus.loading)

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(child: CircularProgressIndicator()),
                      )

                    else if (customers.viewStatus == ViewStatus.error)

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                customers.errorMessage ?? "Ocurrió un error.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.red),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<CustomerProvider>()
                                    .fetchCustomers(),
                                child: const Text("Reintentar"),
                              ),
                            ],
                          ),
                        ),
                      )

                    else if (clientesDeLaPagina.isEmpty)

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),

                        child: Center(
                          child: Text(
                            "No se encontraron clientes.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )

                    else

                      Column(
                        children: clientesDeLaPagina.map((cliente) {
                          return TarjetaCliente(
                            cliente: cliente,
                            onTap: () => mostrarDetalleCliente(context, cliente),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 12),

                    // PAGINACIÓN
                    if (totalPaginas > 1)
                      PaginadorClientes(
                        paginaActual: paginaActual,
                        totalPaginas: totalPaginas,
                        onCambiarPagina: (pagina) {
                          setState(() {
                            _paginaActual = pagina;
                          });
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const menu_Widget(currentIndex: 4),
    );
  }
}