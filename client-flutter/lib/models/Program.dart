import 'package:client_flutter/models/Exercise.dart';

class Program {
  final int? id;
  final String name;
  final String image;
  final List<Exercise> exercises;

  Program(
      {required this.id,
      required this.name,
      required this.exercises,
      required this.image});

  factory Program.fromJson(dynamic json) {
    return Program(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      exercises: (json['exercises'] as List<dynamic>)
          .map((exercise) => Exercise.fromJson(exercise))
          .toList(),
    );
  }
}
