import 'dart:convert';
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
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch data: ${response.body}');
    }
  }
}
