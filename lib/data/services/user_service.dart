import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  static const String baseUrl = 'https://4f5e-160-22-25-26.ngrok-free.app/api';

  static Future<UsersModel?> getUserById(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      final userJson =
          users.firstWhere((u) => u['id'] == userId, orElse: () => null);

      if (userJson != null) {
        return UsersModel.fromJson(userJson);
      }
    }
    return null;
  }
}
