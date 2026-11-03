import 'package:flutter_pasteleria_26/core/constants/api_constants.dart';
import 'package:flutter_pasteleria_26/core/errors/app_exception.dart';
import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/models/sale_model.dart';
 
class SaleRepository {
  final ApiClient _apiClient;
 
  SaleRepository(this._apiClient);
 
  Future<List<SaleModel>> search(Map<String, String>? params) async {
    final Map<int, SaleModel> todas = {};
    int pagina = 1;
    int totalPaginas = 1;
 
    do {
      final json = await _apiClient.get(
        ApiConstants.sales,
        query: {...?params, 'PageNumber': '$pagina', 'PageSize': '50'},
      );
 
      if (json is! Map<String, dynamic>) throw const ParsingException();
 
      final value = json['value'];
      if (value is! Map<String, dynamic>) throw const ParsingException();
 
      final items = value['items'];
      if (items is! List) throw const ParsingException();
 
      for (final item in items) {
        final s = SaleModel.fromJson(item as Map<String, dynamic>);
        todas[s.saleId] = s;
      }
 
      totalPaginas = (value['totalPages'] ?? 1) as int;
      pagina++;
    } while (pagina <= totalPaginas);
 
    return todas.values.toList();
  }
}
 
