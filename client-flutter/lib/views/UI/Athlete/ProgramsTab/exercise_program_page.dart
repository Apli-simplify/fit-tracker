import 'package:client_flutter/views/UI/Athlete/ProgramsTab/cards/CardExercise.dart';
import 'package:flutter/material.dart';
import 'package:client_flutter/models/Program.dart';

class ExerciseProgramPage extends StatelessWidget {
  final Program program;

  const ExerciseProgramPage({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(program.name),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: program.exercises!.isNotEmpty
              ? ListView.builder(
                  itemCount: program.exercises?.length,
                  itemBuilder: (context, index) {
                    return CardExercise(exercise: program.exercises![index]);
                  },
                )
              : const Center(child: Text("No exercises found")),
        ));
  }
}
