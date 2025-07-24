import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reports_model.dart';
import 'endpoint.dart';

class ReportService {
  static Future<List<Report>> fetchReports() async {
    final response = await http.get(Uri.parse('${endpoint.baseUrl}/reports'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> reportsJson = data['reports'];
      return reportsJson.map((json) => Report.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load reports');
    }
  }

  // static Future<void> submitReports({
  //   required int userId,
  //   required List<Map<String, dynamic>> reports,
  // }) async {
  //   final response = await http.post(
  //     Uri.parse('${endpoint.baseUrl}/reports/create'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'user_id': userId,
  //       'reports': reports,
  //     }),
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Gagal mengirim laporan');
  //   }
  // }

  // static Future<void> submitReports({
  //   required int userId,
  //   required List<Map<String, dynamic>> reports,
  // }) async {
  //   final payload = {
  //     'user_id': userId,
  //     'reports': reports,
  //   };
  //
  //   print('Payload: ${jsonEncode(payload)}');
  //
  //   final response = await http.post(
  //     Uri.parse('${endpoint.baseUrl}/reports/create'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(payload),
  //   );
  //
  //   print('Response code: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Gagal mengirim laporan');
  //   }
  // }

  // static Future<void> submitReports({
  //   required int userId,
  //   required List<Map<String, dynamic>> reports,
  // }) async {
  //   for (final report in reports) {
  //     final body = {
  //       'user_id': userId,
  //       'subject_id': report['subject_id'],
  //       'rating': report['rating'],
  //       'note': report['note'],
  //     };
  //
  //     final response = await http.post(
  //       Uri.parse('${endpoint.baseUrl}/reports/create'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(body),
  //     );
  //
  //     print('Sending: ${jsonEncode(body)}');
  //     print('Response code: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //
  //     if (response.statusCode != 200) {
  //       throw Exception('Gagal mengirim laporan: ${response.body}');
  //     }
  //   }
  // }

  static Future<void> submitReports({
    required int userId,
    required List<Map<String, dynamic>> reports,
    String? note, // ✅ Tambahkan ini
  }) async {
    for (final report in reports) {
      final body = {
        'user_id': userId,
        'subject_id': report['subject_id'],
        'rating': report['rating'],
        'note': note ?? '',
      };

      final response = await http.post(
        Uri.parse('${endpoint.baseUrl}/reports/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print('Sending: ${jsonEncode(body)}');
      print('Response code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Gagal mengirim laporan: ${response.body}');
      }
    }
  }
}
