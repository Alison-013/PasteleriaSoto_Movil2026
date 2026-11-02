import 'package:flutter_pasteleria_26/core/constants/category_images.dart';

class InventoryModel {
  final int inventoryId;
  final int productId;
  final String productName;
  final int quantity;
  final int reservedStock;
  final double purchasePrice;
  final double salePrice;

 //api/products
  final String categoryName;
  final String description;

  InventoryModel({
    required this.inventoryId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.reservedStock,
    required this.purchasePrice,
    required this.salePrice,
    this.categoryName = 'Sin categoría',
    this.description = '',
  });

  static InventoryModel fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      inventoryId: json['inventoryId'] as int,
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      quantity: json['quantity'] as int,
      reservedStock: json['reservedStock'] as int,
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      salePrice: (json['salePrice'] as num).toDouble(),
    );
  }

  // Devuelve una copia del mismo registro con la categoría y la descripción.
  InventoryModel conProducto({required String categoryName, required String description}) {
    return InventoryModel(
      inventoryId: inventoryId,
      productId: productId,
      productName: productName,
      quantity: quantity,
      reservedStock: reservedStock,
      purchasePrice: purchasePrice,
      salePrice: salePrice,
      categoryName: categoryName,
      description: description,
    );
  }

   String get imagen => imagenPara(categoria: categoryName, nombre: productName);


  String get estado {
    if (quantity <= 0) return 'Agotado';
    if (quantity <= 5) return 'Bajo stock';
    return 'Disponible';
  }
}