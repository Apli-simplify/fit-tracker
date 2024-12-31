import 'dart:convert'; // Import to handle Base64 decoding
import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/models/Program.dart';
import 'package:client_flutter/views/UI/Athlete/ProgramsTab/exercise_program_page.dart';
import 'package:flutter/material.dart';

class WorkoutRow extends StatelessWidget {
  final Program wObj;
  const WorkoutRow({super.key, required this.wObj});

  @override
  Widget build(BuildContext context) {
    // Decode the Base64 string
    final decodedImage = base64Decode(wObj.image.toString());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: TColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.memory(
              decodedImage,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wObj.name.toString(),
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseProgramPage(program: wObj),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: TColor.primaryColor1,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
