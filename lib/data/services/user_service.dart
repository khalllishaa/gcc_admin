import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {
  static const String baseUrl = 'https://7c4b-160-22-25-46.ngrok-free.app/api';

  static Future<UsersModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return null;

    final response = await http.get(
      Uri.parse('$baseUrl/users/get'),
      headers: {
        'Authorization': 'Bearer $token',
        'ngrok-skip-browser-warning': '1',
      },
    );

    if (response.statusCode == 200) {
      final userJson = jsonDecode(response.body);
      return UsersModel.fromJson(userJson);
    }
    return null;
  }
}
