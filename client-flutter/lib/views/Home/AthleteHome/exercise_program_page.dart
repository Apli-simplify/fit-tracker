import 'package:flutter/material.dart';
import 'package:client_flutter/models/Program.dart';

class ExerciseProgramPage extends StatelessWidget {
  final Program program;

  ExerciseProgramPage({required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(program.name),
        ),
        body: program.exercises.isNotEmpty
            ? ListView.builder(
                itemCount: program.exercises.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            program.exercises[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            program.exercises[index].description,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : const Text(
                "No exercices at the moment",
                style: TextStyle(fontSize: 12),
              ));
  }
}
