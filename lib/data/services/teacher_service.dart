import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/teacher_model.dart';

class TeacherService {
  static const String baseUrl = 'https://7c4b-160-22-25-46.ngrok-free.app/api/teachers';

  Future<List<TeacherModel>> fetchTeachers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => TeacherModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data guru');
    }
  }

  Future<TeacherModel> addTeacher(String name, int classId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'class_id': classId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) {
        throw Exception('Respon kosong dari server');
      }

      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic>) {
        return TeacherModel.fromJson(data);
      } else {
        throw Exception('Format data tidak valid');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<TeacherModel> updateTeacherName(int id, String newName) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': newName}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return TeacherModel.fromJson(data['teacher']);
    } else {
      throw Exception('Failed to update teacher');
    }
  }

  Future<void> deleteTeacher(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus guru');
    }
  }
}
