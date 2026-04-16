import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../utils/constants.dart';

class PostController {
  Future<http.Response> createPost(Post post) async {
    Uri url = Uri.parse('${AppConstants.baseUrl}/posts');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(post.toJson()),
    );

    return response;
  }
}