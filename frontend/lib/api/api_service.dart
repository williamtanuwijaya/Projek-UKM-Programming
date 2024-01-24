import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ukm_project/models/pengguna.dart';

class ApiService {
  String baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> loginUser(Pengguna pengguna) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control_Allow_Origin": "*",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control-Allow-Headers": "X-Requested-With",
        },
        body: jsonEncode(pengguna.toJson()),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Login successful',
          'data': jsonDecode(response.body)['user']
        };
      } else {
        return jsonDecode(response.body);
      }
    } catch (error) {
      print('Error during login request: $error');
      return {'success': false, 'message': 'Failed to connect to the server'};
    }
  }

  Future<Map<String, dynamic>> registerUser(Pengguna pengguna) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/register'),
        headers: {
          'Content-Type': 'application/json',
          "Access-Control_Allow_Origin": "*",
          "Access-Control-Allow-Methods": "POST, OPTIONS",
          "Access-Control-Allow-Headers": "X-Requested-With",
        },
        body: jsonEncode(pengguna.toJson()),
      );

      if (response.statusCode == 201) {
        return {'success': true, 'message': 'Registration successful'};
      } else {
        if (response.body.isNotEmpty &&
            (response.headers['Content-Type']?.contains('application/json') ??
                false)) {
          return jsonDecode(response.body);
        } else {
          return {'success': false, 'message': 'Non-JSON or empty response'};
        }
      }
    } catch (error) {
      print('Error during registration request: $error');
      return {'success': false, 'message': 'Failed to connect to the server'};
    }
  }
}
