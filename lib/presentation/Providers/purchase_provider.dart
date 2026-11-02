import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/purchase_model.dart';
import 'package:flutter_pasteleria_26/services/purchase_service.dart';

class PurchaseProvider extends ChangeNotifier {
  List<PurchaseModel> _purchases = [];
  List<PurchaseModel> get purchases => _purchases;

  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  final PurchaseService _purchaseService;

  PurchaseProvider(this._purchaseService);

  Future<void> fetchPurchases() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();

    try {
      _purchases = await _purchaseService.searchPurchases(null);
      _purchases.sort((a, b) => b.date.compareTo(a.date)); 
      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}
