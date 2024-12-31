import 'package:flutter/material.dart';
import 'package:client_flutter/models/Program.dart';
import 'package:client_flutter/services/AthleteServices/athlete_services.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/common_widget/workout_row.dart';

class MyPlansTab extends StatelessWidget {
  final AthleteServices apiService =
      AthleteServices(baseUrl: ApiConfig.baseUrl);

  MyPlansTab({super.key});

  Future<List<Program>> getProgramsCustoms() async {
    try {
      final programData = await apiService.fecthProgramsDataCustoms();
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
        Expanded(
          child: FutureBuilder<List<Program>>(
            future: getProgramsCustoms(),
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
                      onTap: () {},
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
