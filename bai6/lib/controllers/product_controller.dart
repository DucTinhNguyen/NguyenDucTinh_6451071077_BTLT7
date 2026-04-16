import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../utils/constants.dart';

class ProductController {

  Future<List<Product>> searchProducts(String keyword) async {
    final url = Uri.parse(
      '${AppConstants.baseUrl}${AppConstants.products}?q=$keyword',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List list = data['products'];

      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Search failed');
    }
  }
}