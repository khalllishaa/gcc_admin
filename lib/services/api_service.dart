import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../api_models/class_models.dart';
import '../api_models/user_models.dart';

class ApiService {
  static const String baseUrl = 'https://2862-114-10-8-191.ngrok-free.app/api';

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

  // static Future<Map<String, dynamic>> login(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/auth/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'name': username, 'password': password}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var responseBody = jsonDecode(response.body);
  //     String token = responseBody['token'];  // Ambil token dari respons login
  //     final box = GetStorage();
  //     box.write('token', token);  // Simpan token di GetStorage
  //     return responseBody;
  //   } else {
  //     throw Exception('Login gagal: ${response.statusCode}');
  //   }
  // }

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
      throw Exception('Failed to add class: ${response.statusCode}');
    }
  }

  static Future<void> updateStudent({
    required int id,
    required String name,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/update/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      print('Student updated on API');
    } else {
      throw Exception('Failed to update student: ${response.statusCode}');
    }
  }

  static Future<void> deleteStudent(int studentId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/delete/$studentId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Student deleted successfully');
    } else {
      throw Exception('Failed to delete student: ${response.statusCode}');
    }
  }

  static Future<void> updateClass({
    required int id,
    required String name,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/classes/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 200) {
      print('Class updated successfully');
    } else {
      throw Exception('Failed to update class: ${response.statusCode}');
    }
  }

  static Future<void> deleteClass(int classId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/classes/$classId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Class deleted successfully');
    } else {
      throw Exception('Failed to delete class: ${response.statusCode}');
    }
  }

  static Future<void> addStudent({
    required String name,
    required int classId,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'class_id': classId,
        'role': 'student',
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Student added successfully');
    } else {
      throw Exception('Failed to add student: ${response.statusCode}');
    }
  }

  static Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String longName,
    required String phoneNumber,
    required int classId,
    required String role,
    // required String token,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'long_name': longName,
        'phone_number': phoneNumber,
        'class_id': classId,
        'role': role,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create user: ${response.body}');
    }
  }

}
