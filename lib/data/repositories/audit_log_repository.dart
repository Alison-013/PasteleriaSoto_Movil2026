import 'package:flutter_pasteleria_26/core/constants/api_constants.dart';
import 'package:flutter_pasteleria_26/core/errors/app_exception.dart';
import 'package:flutter_pasteleria_26/core/network/api_client.dart';
import 'package:flutter_pasteleria_26/data/models/audit_log_model.dart';

class AuditLogRepository {
  final ApiClient _apiClient;

  AuditLogRepository(this._apiClient);

  static const int _maxPaginas = 5;

  Future<List<AuditLogModel>> search(Map<String, String>? params) async {
    final Map<String, AuditLogModel> todos = {};
    int pagina = 1;
    int totalPaginas = 1;

    do {
      final json = await _apiClient.get(
        ApiConstants.auditLogs,
        query: {...?params, 'PageNumber': '$pagina', 'PageSize': '100'},
      );

      if (json is! Map<String, dynamic>) throw const ParsingException();

      final value = json['value'];
      if (value is! Map<String, dynamic>) throw const ParsingException();

      final items = value['items'];
      if (items is! List) throw const ParsingException();

      for (final item in items) {
        final log = AuditLogModel.fromJson(item as Map<String, dynamic>);
        todos[log.id] = log;
      }

      totalPaginas = (value['totalPages'] ?? 1) as int;
      pagina++;
    } while (pagina <= totalPaginas && pagina <= _maxPaginas);

    return todos.values.toList();
  }
}