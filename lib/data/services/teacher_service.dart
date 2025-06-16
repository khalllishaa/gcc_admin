import 'dart:convert';
import 'package:gcc_admin/data/services/endpoint.dart';
import 'package:http/http.dart' as http;
import '../models/teacher_model.dart';

class TeacherService {

  Future<List<TeacherModel>> fetchTeachers() async {
    final response = await http.get(Uri.parse('${endpoint.baseUrl}/teachers'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('Fetched Teachers: $data');
      return data.map((json) => TeacherModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat data guru');
    }
  }

  Future<TeacherModel> addTeacher(String name, int classId, String status) async {
    final response = await http.post(
      Uri.parse('${endpoint.baseUrl}/teachers/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'class_id': classId,
        'status': status,
      }),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isEmpty) {
        throw Exception('Respon kosong dari serrver');
      }

      final data = jsonDecode(response.body);
      if (data is Map<String, dynamic>) {
        // return TeacherModel.fromJson(data);
        return TeacherModel.fromJson(data['teacher']);
      } else {
        throw Exception('Format data tidak valid');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  Future<TeacherModel> updateTeacherName(int id, String newName) async {
    final url = Uri.parse('${endpoint.baseUrl}/teachers/$id');
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

  Future<void> updateTeacherStatus(int id, String status) async {
    final response = await http.put(
      Uri.parse('${endpoint.baseUrl}/teachers/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update status');
    }
  }

  Future<void> deleteTeacher(int id) async {
    final response = await http.delete(Uri.parse('${endpoint.baseUrl}/teachers/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus guru');
    }
  }
}
