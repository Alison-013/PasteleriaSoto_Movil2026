import 'package:flutter_pasteleria_26/data/models/supplier_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/supplier_repository.dart';

class SupplierService {
  final SupplierRepository _supplierRepository;

  const SupplierService(this._supplierRepository);

  Future<List<SupplierModel>> searchSuppliers(Map<String, String>? params) async {
    return await _supplierRepository.search(params);
  }
}