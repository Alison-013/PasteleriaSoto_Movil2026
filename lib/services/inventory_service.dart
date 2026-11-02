import 'package:flutter_pasteleria_26/data/models/inventory_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/inventory_repository.dart';

class InventoryService {
  final InventoryRepository _inventoryRepository;

  const InventoryService(this._inventoryRepository);

  Future<List<InventoryModel>> searchInventory(Map<String, String>? params) async {
    return await _inventoryRepository.search(params);
  }
}