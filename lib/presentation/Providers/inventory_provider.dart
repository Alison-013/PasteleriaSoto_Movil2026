// Ubicación: lib/presentation/Providers/inventory_provider.dart  (reemplaza el anterior)
import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/inventory_model.dart';
import 'package:flutter_pasteleria_26/data/models/product_model.dart';
import 'package:flutter_pasteleria_26/services/inventory_service.dart';
import 'package:flutter_pasteleria_26/services/product_service.dart';

class InventoryProvider extends ChangeNotifier {
  List<InventoryModel> _items = [];
  List<InventoryModel> get items => _items;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final InventoryService _inventoryService;
  final ProductService _productService;

  InventoryProvider(this._inventoryService, this._productService);

  Future<void> fetchInventory() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      final inventario = await _inventoryService.searchInventory(null);
      final productos = await _productService.searchProducts(null);

      final Map<int, ProductModel> porId = {
        for (final p in productos) p.productId: p,
      };

      _items = inventario.map((i) {
        final p = porId[i.productId];
        return i.conProducto(
          categoryName: p?.categoryName ?? 'Sin categoría',
          description: p?.description ?? '',
        );
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