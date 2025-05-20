import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/schedule_model.dart';

class ScheduleService {
  static const String baseUrl = 'https://68c6-114-10-23-55.ngrok-free.app/api';

  static Future<List<ScheduleModels>> fetchSchedules() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/schedules'));
      if (response.statusCode == 200) {
        print('Schedule response: ${response.body}');
        return scheduleModelsFromJson(response.body);
      } else {
        print('Error status code: ${response.statusCode}');
        throw Exception('Failed to load schedules');
      }
    } catch (e) {
      print('Error fetching schedules: $e');
      throw Exception('Failed to load schedules');
    }
  }

  static Future<List<ScheduleModels>> fetchSchedulesByClassId(int classId) async {
    final url = Uri.parse('$baseUrl/schedules');
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
      Uri.parse('$baseUrl/schedules/create'),
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
      Uri.parse('$baseUrl/schedules/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus jadwal');
    }
  }

}