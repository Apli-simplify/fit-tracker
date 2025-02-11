import 'dart:convert';
import 'package:client_flutter/models/CustomProgram.dart';
import 'package:http/http.dart' as http;
import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/services/api_config.dart';

class AthleteServices {
  final String baseUrl;

  AthleteServices({required this.baseUrl});
  Future<dynamic> fecthProgramsData() async {
    final url = Uri.parse('$baseUrl${ApiConfig.fetchProgramsDataEndPoint}');

    final token = await SharedPreferencesHelper.getToken();
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

  Future<dynamic> fecthProgramsDataCustoms() async {
    final url =
        Uri.parse('$baseUrl${ApiConfig.fetchProgramsCustomsDataEndPoint}');

    final token = await SharedPreferencesHelper.getToken();
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

  Future<dynamic> fecthAllExercisesData() async {
    final url = Uri.parse('$baseUrl${ApiConfig.fetchExercisesDataEndPoint}');

    final token = await SharedPreferencesHelper.getToken();
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

  Future<dynamic> createCustomProgram(Customprogram customProgram) async {
    final url = Uri.parse('$baseUrl${ApiConfig.createCustomProgramEndPoint}');

    final token = await SharedPreferencesHelper.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'name': customProgram.name,
      'image': customProgram.image,
      'exercises': customProgram.exercises.map((e) => e.toJson()).toList(),
      'status': customProgram.status,
    });
    print(body);
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to create custom program: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating custom program: $e');
    }
  }

  Future<dynamic> changeStatusCustom(Customprogram customProgram) async {
    final url = Uri.parse(
        '$baseUrl${ApiConfig.updateCustomProgram}/${customProgram.id}');

    final token = await SharedPreferencesHelper.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('Authentication token is missing');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'status': customProgram.status,
    });

    try {
      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Failed to change custom program status: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Error changing custom program status: $e');
    }
  }
}
