import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/views/UI/Athlete/home_page_athlete.dart';
import 'package:client_flutter/views/UI/Trainer/home_page_trainer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);
  HomePage({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await apiService.fetchUserData();
      return response;
    } catch (e) {
      print('Error fetching data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fit-Track', style: TextStyle(color: Colors.white)),
        backgroundColor: TColor.primaryColor1,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              await SharedPreferencesHelper.clearTokens();
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data ?? {};
            final role = data['role'] ?? 'unknown';
            print(data);
            // Athlete role
            if (role == 'ROLE_ATHLETE') {
              return HomePageAthlete(data: data);
            }
            // Trainer role
            else if (role == 'ROLE_TRAINER') {
              return TrainerHome();
            } else {
              return Center(
                child: Text(
                  'Unknown role: $role',
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }
          } else {
            return const Center(
              child: Text('No user data found'),
            );
          }
        },
      ),
    );
  }
}
