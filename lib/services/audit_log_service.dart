import 'package:flutter_pasteleria_26/data/models/audit_log_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/audit_log_repository.dart';
 
class AuditLogService {
  final AuditLogRepository _auditLogRepository;
 
  const AuditLogService(this._auditLogRepository);
 
  Future<List<AuditLogModel>> searchLogs(Map<String, String>? params) async {
    return await _auditLogRepository.search(params);
  }
}
 