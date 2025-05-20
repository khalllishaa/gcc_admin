import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';

class AuthService {
  static const String baseUrl = 'https://68c6-114-10-23-55.ngrok-free.app/api';

  static Future<Map<String, dynamic>> login(String name, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'name': name,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final auth = AuthModel.fromJson(data['user']);

      return {
        'message': data['message'],
        'user': auth,
      };
    } else {
      throw Exception('Gagal login: ${response.body}');
    }
  }

}
