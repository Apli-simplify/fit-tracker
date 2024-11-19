import 'dart:convert';
import 'package:client_flutter/services/api_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl${ApiConfig.loginEndpoint}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  // Signup
  Future<Map<String, dynamic>> signup(
      String email, String username, String password) async {
    final url = Uri.parse('$baseUrl${ApiConfig.signupEndpoint}');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'name': username,
        'password': password,
        'role': "ROLE_USER"
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to signup: ${response.body}');
    }
  }

  // Fetch data
  Future<List<dynamic>> fetchData(String token) async {
    final url = Uri.parse('$baseUrl${ApiConfig.fetchDataEndpoint}');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data: ${response.body}');
    }
  }
}
