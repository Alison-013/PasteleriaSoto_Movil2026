import 'package:flutter_pasteleria_26/core/constants/api_constants.dart';
import 'package:flutter_pasteleria_26/core/errors/app_exception.dart';
import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/models/purchase_model.dart';

class PurchaseRepository {
  final ApiClient _apiClient;

  PurchaseRepository(this._apiClient);

  Future<List<PurchaseModel>> search(Map<String, String>? params) async {
    final Map<int, PurchaseModel> todas = {};
    int pagina = 1;
    int totalPaginas = 1;

    do {
      final json = await _apiClient.get(
        ApiConstants.purchases,
        query: {...?params, 'PageNumber': '$pagina', 'PageSize': '50'},
      );

      if (json is! Map<String, dynamic>) throw const ParsingException();

      final value = json['value'];
      if (value is! Map<String, dynamic>) throw const ParsingException();

      final items = value['items'];
      if (items is! List) throw const ParsingException();

      for (final item in items) {
        final p = PurchaseModel.fromJson(item as Map<String, dynamic>);
        todas[p.purchaseId] = p;
      }

      totalPaginas = (value['totalPages'] ?? 1) as int;
      pagina++;
    } while (pagina <= totalPaginas);

    return todas.values.toList();
  }
}
