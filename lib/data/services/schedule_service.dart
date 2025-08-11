import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gcc_admin/data/services/endpoint.dart';
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

  /// Create a new schedule
  static Future<void> createSchedule({
    required String day,
    required String startTime,
    required String endTime,
    required int teacherId,
    required int subjectId,
    required int classId,
    String? teacherName,
    String? subjectName,
  }) async {
    final url = Uri.parse('${endpoint.baseUrl}/schedules/create');

    final body = {
      'day': day,
      'start_time': startTime,
      'end_time': endTime,
      'teacher_id': teacherId,
      'subject_id': subjectId,
      'class_id': classId,
      'teacher': teacherName ?? '', // <-- tambahan
      'subject': subjectName ?? '', // <-- tambahan
    };

    print('>> Sending schedule data: $body');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('>> Response status: ${response.statusCode}');
    print('>> Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Gagal menambahkan jadwal');
    }
  }

  /// Delete a schedule by ID
  static Future<void> deleteSchedule(int id) async {
    final response = await http.delete(
      Uri.parse('${endpoint.baseUrl}/schedules/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Gagal menghapus jadwal');
    }
  }

  /// Fetch all schedules (tanpa filter)
  static Future<List<ScheduleModels>> fetchSchedules() async {
    final response = await http.get(Uri.parse('${endpoint.baseUrl}/schedules'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ScheduleModels.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load schedules');
    }
  }
}