import 'package:flutter/material.dart';

import '/Widgets/TopBar_Widget.dart';
import '/Widgets/menu_Widget.dart';

import 'widgets/buscador_clientes.dart';
import 'widgets/card_clientes.dart';
import 'widgets/filtros_clientes.dart';
import 'widgets/paginacion_clientes.dart';

class ClienteInfo {
  final String nombre;
  final String telefono;
  final int pedidos;
  final String iniciales;
  final Color colorAvatar;

  const ClienteInfo({
    required this.nombre,
    required this.telefono,
    required this.pedidos,
    required this.iniciales,
    required this.colorAvatar,
  });
}

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({super.key});

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final List<ClienteInfo> _clientes = const [
    ClienteInfo(
      nombre: 'Elena Martínez',
      telefono: '+52 55 1234 5678',
      pedidos: 14,
      iniciales: 'EM',
      colorAvatar: Color(0xFF779A9A),
    ),
    ClienteInfo(
      nombre: 'Carlos Rivera',
      telefono: '+52 55 9876 5432',
      pedidos: 8,
      iniciales: 'CR',
      colorAvatar: Color(0xFF587889),
    ),
    ClienteInfo(
      nombre: 'Sofía Guzmán',
      telefono: '+52 55 4567 8901',
      pedidos: 1,
      iniciales: 'SG',
      colorAvatar: Color(0xFFB88F79),
    ),
    ClienteInfo(
      nombre: 'Javier Blanco',
      telefono: '+52 55 2233 4455',
      pedidos: 32,
      iniciales: 'JB',
      colorAvatar: Color(0xFF9C806E),
    ),
    ClienteInfo(
      nombre: 'María González',
      telefono: '+52 55 3344 5566',
      pedidos: 6,
      iniciales: 'MG',
      colorAvatar: Color(0xFF8F7777),
    ),
    ClienteInfo(
      nombre: 'Andrés López',
      telefono: '+52 55 6677 8899',
      pedidos: 3,
      iniciales: 'AL',
      colorAvatar: Color(0xFF678478),
    ),
    ClienteInfo(
      nombre: 'Valeria Cruz',
      telefono: '+52 55 1122 3344',
      pedidos: 11,
      iniciales: 'VC',
      colorAvatar: Color(0xFF9A829A),
    ),
    ClienteInfo(
      nombre: 'Miguel Torres',
      telefono: '+52 55 7788 9900',
      pedidos: 2,
      iniciales: 'MT',
      colorAvatar: Color(0xFF728A9E),
    ),
    ClienteInfo(
      nombre: 'Daniela Ruiz',
      telefono: '+52 55 4455 6677',
      pedidos: 5,
      iniciales: 'DR',
      colorAvatar: Color(0xFFAA896A),
    ),
    ClienteInfo(
      nombre: 'Fernando Reyes',
      telefono: '+52 55 8899 0011',
      pedidos: 9,
      iniciales: 'FR',
      colorAvatar: Color(0xFF647A6A),
    ),
    ClienteInfo(
      nombre: 'Camila Vega',
      telefono: '+52 55 2211 0099',
      pedidos: 4,
      iniciales: 'CV',
      colorAvatar: Color(0xFF8B7890),
    ),
    ClienteInfo(
      nombre: 'Roberto Díaz',
      telefono: '+52 55 9988 7766',
      pedidos: 7,
      iniciales: 'RD',
      colorAvatar: Color(0xFF7D8C91),
    ),
  ];

  final List<String> _filtros = const [
  'Teléfono',
];

  String _textoBusqueda = '';
  String _filtroSeleccionado = 'Todos';
  int _paginaActual = 1;
  final int _clientesPorPagina = 4;

  List<ClienteInfo> get _clientesFiltrados {
    final busqueda = _textoBusqueda.trim().toLowerCase();

    return _clientes.where((cliente) {
      if (busqueda.isEmpty) {
        return true;
      }

      if (_filtroSeleccionado == 'Nombre') {
        return cliente.nombre.toLowerCase().contains(busqueda);
      }

      if (_filtroSeleccionado == 'Teléfono') {
        return cliente.telefono.toLowerCase().contains(busqueda);
      }

      return cliente.nombre.toLowerCase().contains(busqueda) ||
          cliente.telefono.toLowerCase().contains(busqueda);
    }).toList();
  }

  int get _totalPaginas {
    final total =
        (_clientesFiltrados.length / _clientesPorPagina).ceil();

    return total == 0 ? 1 : total;
  }

  @override
  Widget build(BuildContext context) {
    final inicio = (_paginaActual - 1) * _clientesPorPagina;

    final clientesDeLaPagina = _clientesFiltrados
        .skip(inicio)
        .take(_clientesPorPagina)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F7),
      body: SafeArea(
        child: Column(
          children: [
            const TopBar_Widget(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF8A8F92),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
  children: [
    InkWell(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/mas');
      },
      child: const Text(
        'Más Opciones',
        style: TextStyle(
          fontSize: 9,
          color: Color(0xFF8A8F92),
        ),
      ),
    ),
    const SizedBox(width: 4),
    const Icon(
      Icons.chevron_right,
      size: 13,
      color: Color(0xFF8A8F92),
    ),
    const SizedBox(width: 4),
    const Text(
      'Clientes',
      style: TextStyle(
        fontSize: 9,
        color: Color(0xFF25282A),
        fontWeight: FontWeight.w500,
      ),
    ),
  ],
),
                    const SizedBox(height: 10),

                    BuscadorClientes(
                      onChanged: (texto) {
                        setState(() {
                          _textoBusqueda = texto;
                          _paginaActual = 1;
                        });
                      },
                    ),

                    const SizedBox(height: 6),

                    Wrap(
                      spacing: 6,
                      children: _filtros.map((filtro) {
                        return FiltroClienteChip(
                          texto: filtro,
                          seleccionado: _filtroSeleccionado == filtro,
                          onTap: () {
                            setState(() {
                              _filtroSeleccionado = filtro;
                              _paginaActual = 1;
                            });
                          },
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    if (clientesDeLaPagina.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Center(
                          child: Text(
                            'No se encontraron clientes.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF697178),
                            ),
                          ),
                        ),
                      )
                    else
                      ...clientesDeLaPagina.map((cliente) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 22),
                          child: TarjetaCliente(
                            nombre: cliente.nombre,
                            telefono: cliente.telefono,
                            pedidos: cliente.pedidos,
                            iniciales: cliente.iniciales,
                            colorAvatar: cliente.colorAvatar,
                          ),
                        );
                      }),

                    PaginadorClientes(
                      paginaActual: _paginaActual,
                      totalPaginas: _totalPaginas,
                      onCambiarPagina: (pagina) {
                        setState(() {
                          _paginaActual = pagina;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const menu_Widget(currentIndex: 4),
    );
  }
}