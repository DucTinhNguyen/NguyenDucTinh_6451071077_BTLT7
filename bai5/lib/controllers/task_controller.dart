import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';
import '../utils/constants.dart';

class TaskController {

  // GET danh sách task
  Future<List<Task>> getTasks() async {
    final url = Uri.parse('${AppConstants.baseUrl}/todos?_limit=10');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Task.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  // DELETE task
  Future<bool> deleteTask(int id) async {
    final url = Uri.parse('${AppConstants.baseUrl}/todos/$id');

    final response = await http.delete(url);

    return response.statusCode == 200;
  }
}