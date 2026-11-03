class ProductModel {
  final int productId;
  final String productName;
  final String description;
  final String categoryName;
  final String supplierName;
  final bool isActive;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.description,
    required this.categoryName,
    required this.supplierName,
    required this.isActive,
  });

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      description: (json['description'] ?? '') as String,
      categoryName: (json['categoryName'] ?? 'Sin categoría') as String,
      supplierName: (json['supplierName'] ?? '') as String,
      isActive: json['isActive'] as bool,
    );
  }
}