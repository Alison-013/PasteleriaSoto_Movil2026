import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/cliente_model.dart';
import 'package:flutter_pasteleria_26/services/cliente_service.dart';
import 'package:flutter_pasteleria_26/services/sale_service.dart';

class CustomerProvider extends ChangeNotifier {
  List<CustomerModel> _customers = [];
  List<CustomerModel> get customers => _customers;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final CustomerService _customerService;
  final SaleService _saleService;

  CustomerProvider(this._customerService, this._saleService);

  Future<void> fetchCustomers() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      final clientes = await _customerService.searchCustomers(null);
      final ventas = await _saleService.searchSales(null);

      // Cantidad de pedido
      final Map<int, int> pedidos = {};
      for (final v in ventas) {
        pedidos[v.customerId] = (pedidos[v.customerId] ?? 0) + 1;
      }

      _customers = clientes
          .map((c) => c.conPedidos(pedidos[c.customerId] ?? 0))
          .toList();

      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}