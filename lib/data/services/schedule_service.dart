import 'dart:convert';

import 'package:gcc_admin/data/services/endpoint.dart';
import 'package:http/http.dart' as http;

import '../models/schedule_model.dart';

class ScheduleService {

  static Future<List<ScheduleModels>> fetchSchedulesByClassId(int classId) async {
    final url = Uri.parse('${endpoint.baseUrl}/schedules');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);

        return jsonData
            .map((json) => ScheduleModels.fromJson(json))
            .where((schedule) => schedule.classId == classId)
            .toList();
      } else {
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<void> createSchedule({
    required String day,
    required String time,
    required String teacher,
    required String subject,
    required int classId,
  }) async {
    final response = await http.post(
      Uri.parse('${endpoint.baseUrl}/schedules/create'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'day': day,
        'time': time,
        'teacher': teacher,
        'subject': subject,
        'class_id': classId,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambahkan jadwal');
    }
  }

  static Future<void> deleteSchedule(String id) async {
    final response = await http.delete(
      Uri.parse('${endpoint.baseUrl}/schedules/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus jadwal');
    }
  }

}