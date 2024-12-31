import 'package:client_flutter/models/User.dart';

class Athlete extends User {
  double? weight;
  double? height;
  String? goal;

  Athlete(
      {String? id,
      String? name,
      String? email,
      String? password,
      String? gender,
      this.weight,
      this.height,
      this.goal,
      int? age})
      : super(
            id: id,
            name: name,
            email: email!,
            password: password,
            gender: gender,
            age: age);

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['weight'] = weight;
    map['height'] = height;
    map['goal'] = goal;
    return map;
  }

  factory Athlete.fromJson(Map<String, dynamic> json) {
    return Athlete(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      weight: json['weight'],
      height: json['height'],
      goal: json['goal'],
    );
  }

  @override
  String toString() {
    return '${super.toString()}, goal: $goal';
  }
}
