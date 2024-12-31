import 'package:client_flutter/models/Athlete.dart';
import 'package:client_flutter/models/Exercise.dart';
import 'package:client_flutter/models/Program.dart';

class Customprogram extends Program {
  final String? status;
  final Athlete? athlete;

  Customprogram({
    int? id,
    required String name,
    required String image,
    required List<Exercise> exercises,
    this.status,
    this.athlete,
  }) : super(
          id: id,
          name: name,
          image: image,
          exercises: exercises,
        );

  factory Customprogram.fromJson(Map<String, dynamic> json) {
    return Customprogram(
      id: json['id'] as int?,
      name: json['name'] as String,
      image: json['image'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map(
              (exercise) => Exercise.fromJson(exercise as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      athlete:
          json['athlete'] != null ? Athlete.fromJson(json['athlete']) : null,
    );
  }
}
