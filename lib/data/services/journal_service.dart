import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/journal_model.dart';
import 'endpoint.dart';

class JournalService {
  static Future<List<JournalModel>> fetchJournals({
    required int classId,
    required String date,
  }) async {
    try {
      final url = '${endpoint.baseUrl}/journals?class_id=$classId&date=$date';
      print('Fetching journals from: $url');
      
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          // Tambahkan auth header jika diperlukan
          // 'Authorization': 'Bearer $token',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        
        // Handle different response structures
        List<dynamic> jsonList;
        if (responseData is Map<String, dynamic>) {
          // Jika response berupa object dengan property data
          if (responseData.containsKey('data')) {
            jsonList = responseData['data'] as List<dynamic>;
          } else if (responseData.containsKey('journals')) {
            jsonList = responseData['journals'] as List<dynamic>;
          } else {
            // Jika response object tapi tidak ada property data/journals
            print('Unexpected response structure: $responseData');
            return [];
          }
        } else if (responseData is List) {
          // Jika response langsung berupa array
          jsonList = responseData;
        } else {
          print('Unexpected response type: ${responseData.runtimeType}');
          return [];
        }
        
        print('Found ${jsonList.length} journals in response');
        
        final journals = jsonList.map((json) {
          try {
            return JournalModel.fromJson(json);
          } catch (e) {
            print('Error parsing journal item: $e');
            print('Problem item: $json');
            return null;
          }
        }).where((journal) => journal != null).cast<JournalModel>().toList();
        
        print('Successfully parsed ${journals.length} journals');
        return journals;
        
      } else if (response.statusCode == 404) {
        print('No journals found for the specified date and class');
        return [];
      } else {
        print('Failed to load journals. Status: ${response.statusCode}');
        print('Error response: ${response.body}');
        throw Exception('Failed to load journals: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in JournalService.fetchJournals: $e');
      // Tidak throw exception, return empty list untuk UX yang lebih baik
      return [];
    }
  }

  static Future<bool> postJournal(CreateJournalModel journal) async {
    try {
      final url = '${endpoint.baseUrl}/journals/create';
      print('Posting journal to: $url');
      
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Tambahkan data form
      request.fields['classroom_id'] = journal.classroomId.toString();
      request.fields['subject_id'] = journal.subjectId.toString();
      request.fields['teacher_id'] = journal.teacherId.toString();

      // Kalau ada file, attach ke request
      if (journal.filePath != null && journal.filePath!.isNotEmpty) {
        try {
          File file = File(journal.filePath!);
          if (await file.exists()) {
            var fileSize = await file.length();
            print('Attaching file: ${journal.filePath} (${fileSize} bytes)');
            
            request.files.add(await http.MultipartFile.fromPath(
              'file', // key yang diharapkan backend
              journal.filePath!,
            ));
          } else {
            print('File does not exist: ${journal.filePath}');
          }
        } catch (e) {
          print('Error attaching file: $e');
          // Lanjutkan tanpa file jika ada error
        }
      }

      // Tambahkan headers
      request.headers.addAll({
        'Accept': 'application/json',
        // Tambahkan token auth jika diperlukan
        // 'Authorization': 'Bearer $token',
      });

      print('Request fields: ${request.fields}');
      print('Request files: ${request.files.length} files');

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();
      
      print('Response Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final jsonResponse = json.decode(responseBody);
          
          // Check jika backend mengembalikan status success
          if (jsonResponse is Map<String, dynamic>) {
            if (jsonResponse.containsKey('success') && jsonResponse['success'] == false) {
              print('Backend returned error: ${jsonResponse['message'] ?? 'Unknown error'}');
              return false;
            }
          }
          
          print('Journal posted successfully');
          return true;
        } catch (e) {
          // Jika tidak bisa parse JSON, tapi status code OK, anggap berhasil
          print('Could not parse JSON response, but status code is OK: $e');
          return true;
        }
      } else {
        print('HTTP Error: ${response.statusCode}');
        try {
          final errorResponse = json.decode(responseBody);
          print('Error details: $errorResponse');
        } catch (e) {
          print('Could not parse error response: $e');
        }
        return false;
      }
    } catch (e) {
      print('Error posting journal: $e');
      return false;
    }
  }

  // Method tambahan untuk debugging
  static Future<Map<String, dynamic>> getJournalStats({
    required int classId,
    required String date,
  }) async {
    try {
      final url = '${endpoint.baseUrl}/journals/stats?class_id=$classId&date=$date';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      
      return {'error': 'Failed to get stats'};
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<JournalModel> getJournalById(int id) async {
    final url = '${endpoint.baseUrl}/journals/$id';

    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return JournalModel.fromJson(data['data'] ?? data); // tergantung struktur response-mu
    } else {
      throw Exception('Failed to load journal by ID: ${response.statusCode}');
    }
  }

}