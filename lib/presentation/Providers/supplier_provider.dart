import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/supplier_model.dart';
import 'package:flutter_pasteleria_26/services/product_service.dart';
import 'package:flutter_pasteleria_26/services/supplier_service.dart';

class SupplierProvider extends ChangeNotifier {
  List<SupplierModel> _suppliers = [];
  List<SupplierModel> get suppliers => _suppliers;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final SupplierService _supplierService;
  final ProductService _productService;

  SupplierProvider(this._supplierService, this._productService);

  Future<void> fetchSuppliers() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      final proveedores = await _supplierService.searchSuppliers(null);
      final productos = await _productService.searchProducts(null);

      // Categorías de los productos que vende cada proveedor.
      final Map<String, Set<String>> categorias = {};
      for (final p in productos) {
        (categorias[p.supplierName] ??= <String>{}).add(p.categoryName);
      }

      _suppliers = proveedores.map((s) {
        final c = categorias[s.supplierName];
        return s.conDetalle(c == null || c.isEmpty ? 'Sin productos' : c.join(', '));
      }).toList();

      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}