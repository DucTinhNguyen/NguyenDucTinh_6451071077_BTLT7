import '../models/user_model.dart';
import '../services/user_api_service.dart';

class UserRepository {
  final UserApiService apiService = UserApiService();

  Future<List<User>> fetchUsers() async {
    final data = await apiService.getUsers();
    return data.map<User>((e) => User.fromJson(e)).toList();
  }
}