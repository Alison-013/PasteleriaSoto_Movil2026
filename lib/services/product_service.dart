import 'package:flutter_pasteleria_26/data/models/product_model.dart';
import 'package:flutter_pasteleria_26/data/repositories/product_repository.dart';

class ProductService {
  final ProductRepository _productRepository;

  const ProductService(this._productRepository);

  Future<List<ProductModel>> searchProducts(Map<String, String>? params) async {
    return await _productRepository.search(params);
  }
}