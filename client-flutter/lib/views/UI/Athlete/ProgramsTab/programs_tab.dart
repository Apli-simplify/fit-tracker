import 'package:flutter/material.dart';
import 'package:client_flutter/models/Program.dart';
import 'package:client_flutter/services/AthleteServices/athlete_services.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/common_widget/workout_row.dart';
import 'select_exercises_page.dart'; // Import the new page

class ProgramsTab extends StatelessWidget {
  final AthleteServices apiService =
      AthleteServices(baseUrl: ApiConfig.baseUrl);

  ProgramsTab({super.key});

  Future<List<Program>> getPrograms() async {
    try {
      final programData = await apiService.fecthProgramsData();
      if (programData is List && programData.isNotEmpty) {
        return programData.map((program) => Program.fromJson(program)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      print('Error fetching programs: $ex');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Button to planify a training session
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectExercisesPage(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Planify a Training Session',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // List of programs
        Expanded(
          child: FutureBuilder<List<Program>>(
            future: getPrograms(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error loading programs"));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final programs = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: programs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Handle program tap if needed
                      },
                      child: WorkoutRow(wObj: programs[index]),
                    );
                  },
                );
              } else {
                return const Center(child: Text("No programs found."));
              }
            },
          ),
        ),
      ],
    );
  }
}
