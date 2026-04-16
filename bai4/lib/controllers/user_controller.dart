import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';

class UserController {
  Future<User> getUser(int id) async {
    final url = Uri.parse('${AppConstants.baseUrl}/users/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<http.Response> updateUser(int id, User user) async {
    final url = Uri.parse('${AppConstants.baseUrl}/users/$id');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    return response;
  }
}