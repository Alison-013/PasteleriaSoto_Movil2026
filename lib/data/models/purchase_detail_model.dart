class PurchaseDetailModel {
  final int id;
  final int productId;
  final String productName;
  final int quantity;
  final double purchasePrice;
  final double total;

  PurchaseDetailModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.purchasePrice,
    required this.total,
  });

  static PurchaseDetailModel fromJson(Map<String, dynamic> json) {
    return PurchaseDetailModel(
      id: json['id'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
}
