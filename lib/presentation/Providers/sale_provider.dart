import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/sale_model.dart';
import 'package:flutter_pasteleria_26/services/sale_service.dart';
 
class SaleProvider extends ChangeNotifier {
  List<SaleModel> _sales = [];
  List<SaleModel> get sales => _sales;
 
  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;
 
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
 
  final SaleService _saleService;
 
  SaleProvider(this._saleService);
 
  Future<void> fetchSales() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();
 
    try {
      _sales = await _saleService.searchSales(null);
      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}