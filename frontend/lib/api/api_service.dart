import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ukm_project/models/pengguna.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> loginUser(Pengguna pengguna) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pengguna.toJson()),
      );

      if (response.statusCode == 200) {
        return {'success': true, 'message': 'Login successful'};
      } else {
        return jsonDecode(response.body);
      }
    } catch (error) {
      print('Error during login request: $error');
      return {'success': false, 'message': 'Failed to connect to the server'};
    }
  }
}
