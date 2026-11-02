import 'package:flutter/material.dart';
import 'package:flutter_pasteleria_26/core/constants/view_status.dart';
import 'package:flutter_pasteleria_26/data/models/audit_log_model.dart';
import 'package:flutter_pasteleria_26/services/audit_log_service.dart';
 
class ActivityProvider extends ChangeNotifier {
  List<AuditLogModel> _logs = [];
  List<AuditLogModel> get logs => _logs;
 
  ViewStatus _viewStatus = ViewStatus.initial;
  ViewStatus get viewStatus => _viewStatus;
 
  String? _errorMessage;
  String? get errorMessage => _errorMessage;
 
  final AuditLogService _auditLogService;
 
  ActivityProvider(this._auditLogService);
 
  Future<void> fetchLogs() async {
    _viewStatus = ViewStatus.loading;
    notifyListeners();
 
    try {
      _logs = await _auditLogService.searchLogs(null);
      _logs.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // más nuevo primero
      _viewStatus = ViewStatus.success;
    } catch (e) {
      _errorMessage = e.toString();
      _viewStatus = ViewStatus.error;
    } finally {
      notifyListeners();
    }
  }
}