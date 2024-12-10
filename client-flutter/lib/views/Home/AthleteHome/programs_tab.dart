import 'package:flutter/material.dart';
import 'package:client_flutter/models/Program.dart';
import 'package:client_flutter/services/AthleteServices/athlete_services.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/common_widget/workout_row.dart';

class ProgramsTab extends StatelessWidget {
  final AthleteServices apiService =
      AthleteServices(baseUrl: ApiConfig.baseUrl);

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
    return FutureBuilder<List<Program>>(
      future: getPrograms(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading programs"));
        } else if (snapshot.hasData) {
          final programs = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: programs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  // Handle tap
                },
                child: WorkoutRow(wObj: programs[index]),
              );
            },
          );
        } else {
          return Center(child: Text("No programs found."));
        }
      },
    );
  }
}
