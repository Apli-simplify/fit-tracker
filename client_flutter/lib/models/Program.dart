import 'package:client_flutter/models/Exercise.dart';

class Program {
  final int id;
  final String name;
  final List<Exercise> exercises;

  Program({
    required this.id,
    required this.name,
    required this.exercises,
  });

  factory Program.fromJson(dynamic json) {
    return Program(
      id: json['id'],
      name: json['name'],
      exercises: [],
    );
  }
}
