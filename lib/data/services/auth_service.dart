import 'dart:convert';
import 'package:gcc_admin/data/services/endpoint.dart';
import 'package:http/http.dart' as http;
import '../models/auth_model.dart';

class AuthService {

  static Future<Map<String, dynamic>> login(String name, String password) async {
    final response = await http.post(
      Uri.parse('${endpoint.baseUrl}/auth/login'),
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
