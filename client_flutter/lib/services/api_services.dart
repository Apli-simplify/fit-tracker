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
  Future<Map<String, dynamic>> signup(Map<String, String> data) async {
    final url = Uri.parse(
      '$baseUrl${data["isAthlete"] == "true" ? ApiConfig.signupEndpointAthletes : ApiConfig.signupEndpointTrainers}',
    );

    if (data["isAthlete"] == "false") {
      // Trainer signup
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': data["email"],
          'name': data["username"],
          'password': data["password"],
          'role': "ROLE_TRAINER",
        }),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to signup: ${response.body}');
      }
    } else {
      // Athlete signup
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': data["email"],
          'name': data["username"],
          'password': data["password"],
          'height': data["height"],
          'weight': data["weight"],
          'role': "ROLE_ATHLETE",
        }),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to signup: ${response.body}');
      }
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
