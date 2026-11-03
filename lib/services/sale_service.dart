import 'package:flutter_pasteleria_26/data/models/sale_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/sale_repository.dart';
 
class SaleService {
  final SaleRepository _saleRepository;
 
  const SaleService(this._saleRepository);
 
  Future<List<SaleModel>> searchSales(Map<String, String>? params) async {
    return await _saleRepository.search(params);
  }
}
 