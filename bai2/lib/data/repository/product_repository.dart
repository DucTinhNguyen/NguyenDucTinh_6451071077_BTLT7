import '../models/product_model.dart';
import '../services/product_api_service.dart';

class ProductRepository {
  final ProductApiService apiService = ProductApiService();

  Future<Product> fetchProduct() async {
    final data = await apiService.getProduct();
    return Product.fromJson(data);
  }
}