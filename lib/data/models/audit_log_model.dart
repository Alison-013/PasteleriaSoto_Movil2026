class AuditLogModel {
  final String id;
  final DateTime timestamp;
  final String traceId;
  final String level;
  final String method;
  final String path;
  final int statusCode;
  final int elapsedMilliseconds;
 
  AuditLogModel({
    required this.id,
    required this.timestamp,
    required this.traceId,
    required this.level,
    required this.method,
    required this.path,
    required this.statusCode,
    required this.elapsedMilliseconds,
  });
 
  static AuditLogModel fromJson(Map<String, dynamic> json) {
    return AuditLogModel(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String).toLocal(),
      traceId: json['traceId'] as String,
      level: json['level'] as String,
      method: json['method'] as String,
      path: json['path'] as String,
      statusCode: json['statusCode'] as int,
      elapsedMilliseconds: json['elapsedMilliseconds'] as int,
    );
  }
}