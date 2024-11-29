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

  Future<Map<String, dynamic>> signup(Map<String, String> data) async {
    print(data);
    final isAthlete = data["isAthlete"] == "true";
    final endpoint = isAthlete
        ? ApiConfig.signupEndpointAthletes
        : ApiConfig.signupEndpointTrainers;
    final role = isAthlete ? "ROLE_ATHLETE" : "ROLE_TRAINER";
    final url = Uri.parse('$baseUrl$endpoint');

    final body = {
      'email': data["email"],
      'name': data["name"],
      'password': data["password"],
      'gender': data["gender"],
      'role': role,
    };

    if (isAthlete) {
      body.addAll({
        'height': data["height"],
        'weight': data["weight"],
        'goal': data["goal"],
        'age': data["age"]
      });
    }

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw Exception('Failed to signup: ${error['message'] ?? response.body}');
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
