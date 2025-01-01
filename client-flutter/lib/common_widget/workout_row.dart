import 'package:client_flutter/models/CustomProgram.dart';
import 'package:client_flutter/services/AthleteServices/athlete_services.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:flutter/material.dart';
import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/models/Program.dart';
import 'package:client_flutter/views/UI/Athlete/ProgramsTab/exercise_program_page.dart';

class WorkoutRow extends StatelessWidget {
  final Program wObj;
  WorkoutRow({super.key, required this.wObj});
  final AthleteServices apiService =
      AthleteServices(baseUrl: ApiConfig.baseUrl);

  @override
  Widget build(BuildContext context) {
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
            child: Image.network(
              wObj.image.toString(),
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
                if (wObj is Customprogram)
                  Text(
                    (wObj as Customprogram).status.toString(),
                    style: TextStyle(
                      color:
                          (wObj as Customprogram).status.toString() == "Active"
                              ? Colors.green
                              : Colors.red,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
          if (wObj is Customprogram)
            IconButton(
              onPressed: () async {
                await apiService.changeStatusCustom(wObj as Customprogram);
              },
              icon: Icon(
                Icons.play_arrow,
                color: TColor.primaryColor2,
                size: 24,
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
