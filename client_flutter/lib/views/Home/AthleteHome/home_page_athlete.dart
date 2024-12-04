import 'package:client_flutter/models/Program.dart';
import 'package:client_flutter/services/AthleteServices/athlete_services.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/views/Home/AthleteHome/widgets/home_statistics.dart';
import 'package:client_flutter/views/cards/program_card.dart';
import 'package:flutter/material.dart';

class AthleteHome extends StatelessWidget {
  final Map<String, dynamic> data;
  final AthleteServices apiService =
      AthleteServices(baseUrl: ApiConfig.baseUrl);

  AthleteHome({required this.data});

  Future<List<Program>> getPrograms() async {
    try {
      final programData = await apiService.fecthProgramsData();

      if (programData is List && programData.isNotEmpty) {
        List<Program> programs =
            programData.map((program) => Program.fromJson(program)).toList();

        if (programs.isNotEmpty) {
          print("name ${programs[0].name} ");
        }

        return programs;
      } else {
        print('No programs available.');
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
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.hasData) {
          final programs = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, ${data['name']}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'This is your personalized dashboard.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const HomeStatistics(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Programs:',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: programs.length,
                        itemBuilder: (context, index) {
                          final program = programs[index];
                          return ProgramCard(program: program);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return Center(child: Text('No data available.'));
      },
    );
  }
}
