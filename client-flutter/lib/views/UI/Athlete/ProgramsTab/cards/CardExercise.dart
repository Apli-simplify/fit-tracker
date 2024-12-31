import 'package:client_flutter/models/Exercise.dart';
import 'package:client_flutter/views/UI/Athlete/ProgramsTab/exercise_details.dart';
import 'package:flutter/material.dart';

class CardExercise extends StatelessWidget {
  final Exercise exercise;

  const CardExercise({required this.exercise, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tapped on exercise: ${exercise.name}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExerciseDetails(exercise: exercise),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.fitness_center,
                    color: Colors.deepPurple,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                exercise.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 100, 54, 54),
                ),
              ),
              const SizedBox(height: 10),
              if (exercise.duration != null)
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 16,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${exercise.duration! ~/ 60} minutes",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 176, 118, 118),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
