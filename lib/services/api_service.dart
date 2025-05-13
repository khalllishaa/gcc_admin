import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_models/class_models.dart';
import '../api_models/user_models.dart';

class ApiService {
  static const String baseUrl = 'https://c0ae-160-22-25-26.ngrok-free.app/api';

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login gagal: ${response.statusCode}');
    }
  }

  static Future<List<ClassModel>> fetchClasses() async {
    final response = await http.get(Uri.parse('$baseUrl/classes'));

    if (response.statusCode == 200) {
      return classModelFromJson(response.body);
    } else {
      throw Exception('Failed to load classes');
    }
  }

  static Future<List<User>> fetchStudents(int classId) async {
    final response = await http.get(Uri.parse('$baseUrl/classes/$classId/students'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['users'] as List).map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  static Future<void> addStudent({
    required String name,
    required int classId,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'class_id': classId,
      }),
    );

    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 302) {
      String redirectUrl = response.headers['location'] ?? '';
      if (redirectUrl.isNotEmpty) {
        print('Redirecting to: $redirectUrl');
        final redirectResponse = await http.get(Uri.parse(redirectUrl));
        if (redirectResponse.statusCode == 200) {
          print('Redirected successfully: ${redirectResponse.body}');
        } else {
          throw Exception('Failed to redirect to new URL');
        }
      }
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambahkan siswa');
    }
  }

  static Future<UsersModel?> getUserById(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      List<dynamic> users = jsonDecode(response.body);
      final userJson = users.firstWhere((u) => u['id'] == userId, orElse: () => null);

      if (userJson != null) {
        return UsersModel.fromJson(userJson);
      }
    }
    return null;
  }

  static Future<void> addClass(String className) async {
    final response = await http.post(
      Uri.parse('$baseUrl/classes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': className}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Class added successfully');
    } else {
      // Throw an exception for any other status codes
      throw Exception('Failed to add class: ${response.statusCode}');
    }
  }
  


}
