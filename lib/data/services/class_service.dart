import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/class_model.dart';

class ClassService {
  static const String baseUrl = 'https://4f5e-160-22-25-26.ngrok-free.app/api';

  static Future<List<ClassModel>> fetchClasses() async {
    final response = await http.get(Uri.parse('$baseUrl/classes'));

    if (response.statusCode == 200) {
      return classModelFromJson(response.body);
    } else {
      throw Exception('Failed to load classes');
    }
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

  static Future<List<User>> fetchStudents(int classId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/classes/$classId/students'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['users'] as List)
          .map((user) => User.fromJson(user))
          .toList();
    } else {
      throw Exception('Failed to load students');
    }
  }
}
