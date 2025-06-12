import 'dart:convert';
import 'package:gcc_admin/data/services/endpoint.dart';
import 'package:http/http.dart' as http;
import '../models/subject_model.dart';

class SubjectService {

  Future<List<SubjectModel>> fetchSubjects() async {
    final url = Uri.parse('${endpoint.baseUrl}/subjects');
    final response = await http.get(url);

    print('Status Code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      return subjectModelFromJson(response.body);
    } else {
      throw Exception('Failed to load subjects');
    }
  }

  Future<void> addSubject(String name) async {
    final response = await http.post(
      Uri.parse('${endpoint.baseUrl}/subjects/create'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'name': name}),
    );

    if (response.statusCode == 201) {
      print('Subject berhasil ditambahkan');
    } else {
      print('Gagal menambahkan subject: ${response.body}');
    }
  }

  Future<void> editSubject(int id, String newName) async {
    final response = await http.put(
      Uri.parse('${endpoint.baseUrl}/subjects/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'name': newName}),
    );

    if (response.statusCode == 200) {
      print('Subject berhasil diupdate');
    } else {
      print('Gagal update subject: ${response.body}');
    }
  }

  Future<void> deleteSubject(int id) async {
    final response = await http.delete(
      Uri.parse('${endpoint.baseUrl}/subjects/$id'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Subject berhasil dihapus');
    } else {
      print('Gagal hapus subject: ${response.body}');
    }
  }


}
