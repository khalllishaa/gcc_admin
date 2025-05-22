import 'dart:convert';
import 'package:gcc_admin/data/services/endpoint.dart';
import 'package:http/http.dart' as http;

class StudentService {

  static Future<void> addStudent({
    required String name,
    required int classId,
  }) async {
    final response = await http.post(
      Uri.parse('${endpoint.baseUrl}/auth/register'),
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
}
