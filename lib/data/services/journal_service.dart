import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/journal_model.dart';
import 'endpoint.dart';

class JournalService {
  static Future<List<JournalModel>> fetchJournals({
    required int classId,
    required String date,
  }) async {
    try {
      final response = await http.get(Uri.parse(
        '${endpoint.baseUrl}/journals?class_id=$classId&date=$date',
      ));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => JournalModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load journals');
      }
    } catch (e) {
      print('Error in JournalService: $e');
      return [];
    }
  }

  // static Future<bool> postJournal(CreateJournalModel journal) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('${endpoint.baseUrl}/journals/create'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(journal.toJson()),
  //     );
  //
  //     print('Response Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //
  //     return response.statusCode == 200 || response.statusCode == 201;
  //   } catch (e) {
  //     print('Error posting journal: $e');
  //     return false;
  //   }
  // }

  static Future<bool> postJournal(CreateJournalModel journal) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${endpoint.baseUrl}/journals/create'),
      );

      request.fields['classroom_id'] = journal.classroomId.toString();
      request.fields['subject_id'] = journal.subjectId.toString();
      request.fields['teacher_id'] = journal.teacherId.toString();

      // Kalau ada file, attach ke request
      if (journal.filePath != null && journal.filePath!.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'file', // pastikan ini sama dengan key yang diharapkan backend
          journal.filePath!,
        ));
      }

      var response = await request.send();
      print('Response Code: ${response.statusCode}');

      final responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error posting journal: $e');
      return false;
    }
  }

}
