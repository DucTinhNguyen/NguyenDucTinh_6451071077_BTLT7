import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../utils/constants.dart';

class ArticleController {

  Future<List<Article>> getArticles() async {
    final url = Uri.parse('${AppConstants.baseUrl}${AppConstants.posts}?_limit=10');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Article.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}