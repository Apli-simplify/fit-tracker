import 'package:client_flutter/models/Program.dart';
import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final Program program;

  const ProgramCard({required this.program});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          program.name ?? 'Program Name',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
