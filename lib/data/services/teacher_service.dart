import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/teacher_model.dart';

class TeacherService {
  static const String baseUrl = 'https://4f5e-160-22-25-26.ngrok-free.app/api/teachers';

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
    Uri.parse('$baseUrl/create'), // tambahkan '/create' di sini
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'name': name, 'class_id': classId}),
  );

  if (response.statusCode == 201) {
    return TeacherModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Gagal menambahkan guru');
  }
}


  Future<void> deleteTeacher(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus guru');
    }
  }
}
