import 'dart:convert';
import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/models/Athlete.dart';
import 'package:client_flutter/models/User.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

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

  Future<Map<String, dynamic>> signup(User user) async {
    final endpoint = user is Athlete
        ? ApiConfig.signupEndpointAthletes
        : ApiConfig.signupEndpointTrainers;

    final role = user is Athlete ? "ROLE_ATHLETE" : "ROLE_TRAINER";
    final url = Uri.parse('$baseUrl$endpoint');

    final body = {
      'email': user.email,
      'name': user.name,
      'password': user.password,
      'gender': user.gender,
      'role': role,
      'age': user.age
    };

    if (user is Athlete) {
      body.addAll({
        'height': user.height.toString(),
        'weight': user.weight.toString(),
        'goal': user.goal.toString(),
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
      throw Exception('Failed to signup: ${error['error'] ?? response.body}');
    }
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final url = Uri.parse('$baseUrl${ApiConfig.fetchUserDataEndpoint}');

    final token = await SharedPreferencesHelper.getToken();
    print(token);
    if (token == null || token.isEmpty) {
      return {};
    }
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
