import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApiService {
  Future<Map<String, dynamic>> getProduct() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products/1'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }
}