class SaleDetailModel {
  final int productId;
  final String productName;
  final int quantity;
  final double salePrice;
  final double lineAmount;
 
  SaleDetailModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.salePrice,
    required this.lineAmount,
  });
 
  static SaleDetailModel fromJson(Map<String, dynamic> json) {
    return SaleDetailModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      salePrice: (json['salePrice'] as num).toDouble(),
      lineAmount: (json['lineAmount'] as num).toDouble(),
    );
  }
}