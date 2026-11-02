import 'package:flutter_pasteleria_26/data/models/purchase_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/purchase_repository.dart';

class PurchaseService {
  final PurchaseRepository _purchaseRepository;

  const PurchaseService(this._purchaseRepository);

  Future<List<PurchaseModel>> searchPurchases(Map<String, String>? params) async {
    return await _purchaseRepository.search(params);
  }
}
