import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);
  HomePage({super.key});

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await apiService.fetchData();
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
        title: const Text('Home'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Home Page!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'You are logged in successfully.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('Navigate to another screen');
              },
              child: const Text('Go to Dashboard'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Navigate to Settings');
              },
              child: const Text('Go to Settings'),
            ),
            const SizedBox(height: 40),

            // Use FutureBuilder to fetch user info and display role
            FutureBuilder<Map<String, dynamic>>(
              future: fetchData(), // Call the fetchUserInfo method
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading indicator while waiting
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  // Display error if fetching fails
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  // Extract role from the fetched user data
                  final data = snapshot.data ?? {};
                  final role = data['role'] ?? 'No role available';

                  return Column(
                    children: [
                      const Text(
                        'Your Role:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        role, // Display the role
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text('No user data found');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
