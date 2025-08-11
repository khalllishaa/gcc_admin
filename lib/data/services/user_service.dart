import 'dart:convert';
import 'dart:convert';
import 'dart:io';
import 'package:gcc_admin/data/services/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class UserService {

  static Future<UsersModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return null;

    final response = await http.get(
      Uri.parse('${endpoint.baseUrl}/users/get'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userData = data['user'];
      return UsersModel.fromJson(userData);
    }
    return null;
  }

  static Future<bool> uploadProfilePicture(int userId, File imageFile) async {
    final uri = Uri.parse('${endpoint.baseUrl}/users/update/$userId');
    final request = http.MultipartRequest('POST', uri)
      ..fields['_method'] = 'PUT'
      ..files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        imageFile.path,
      ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('Upload response: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode == 200;
  }
}
