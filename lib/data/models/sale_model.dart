import 'package:flutter_pasteleria_26/data/models/sale_detail_model.dart';
 
class SaleModel {
  final int saleId;
  final int customerId;
  final String customerName;
  final DateTime saleDate;
  final double saleTotal;
  final List<SaleDetailModel> details;
 
  SaleModel({
    required this.saleId,
    required this.customerId,
    required this.customerName,
    required this.saleDate,
    required this.saleTotal,
    required this.details,
  });
 

  static SaleModel fromJson(Map<String, dynamic> json) {
    final rawDetails = (json['saleDetails'] ?? []) as List;
 
    return SaleModel(
      saleId: json['saleId'] as int,
      customerId: json['customerId'] as int,
      customerName: json['customerName'] as String,
      saleDate: DateTime.parse(json['saleDate'] as String),
      saleTotal: (json['saleTotal'] as num).toDouble(),
      details: rawDetails
          .map((d) => SaleDetailModel.fromJson(d as Map<String, dynamic>))
          .toList(),
    );
  }
}
 