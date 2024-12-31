import 'package:client_flutter/models/User.dart';

class Trainer extends User {
  bool availableStatus;

  Trainer({
    String? id,
    String? name,
    required String email,
    String? password,
    String? gender,
    int? age,
    this.availableStatus = true,
  }) : super(
            id: id,
            name: name,
            email: email,
            password: password,
            gender: gender,
            age: age);

  void toggleAvailability() {
    availableStatus = !availableStatus;
  }

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map['availableStatus'] = availableStatus;
    return map;
  }

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      availableStatus: json['availableStatus'] ?? true,
    );
  }

  @override
  String toString() {
    return '${super.toString()}, availableStatus: $availableStatus';
  }
}
