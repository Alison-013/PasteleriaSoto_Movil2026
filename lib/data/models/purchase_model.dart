import 'package:flutter_pasteleria_26/data/models/purchase_detail_model.dart';

class PurchaseModel {
  final int purchaseId;
  final int supplierId;
  final String supplierName;
  final DateTime date;
  final double totalAmount;
  final List<PurchaseDetailModel> details;

  PurchaseModel({
    required this.purchaseId,
    required this.supplierId,
    required this.supplierName,
    required this.date,
    required this.totalAmount,
    required this.details,
  });

  static PurchaseModel fromJson(Map<String, dynamic> json) {
    final rawDetails = (json['purchaseDetails'] ?? []) as List;

    return PurchaseModel(
      purchaseId: json['purchaseId'] as int,
      supplierId: json['supplierId'] as int,
      supplierName: json['supplierName'] as String,
      date: DateTime.parse(json['date'] as String),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      details: rawDetails.map((d) => PurchaseDetailModel.fromJson(d as Map<String, dynamic>)).toList(),
    );
  }
}
