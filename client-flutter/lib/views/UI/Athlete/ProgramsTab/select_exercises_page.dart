import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/models/Athlete.dart';
import 'package:client_flutter/models/CustomProgram.dart';
import 'package:flutter/material.dart';
import 'package:client_flutter/models/Exercise.dart';
import 'package:client_flutter/services/AthleteServices/athlete_services.dart';
import 'package:client_flutter/services/api_config.dart';

class SelectExercisesPage extends StatefulWidget {
  const SelectExercisesPage({super.key});

  @override
  _SelectExercisesPageState createState() => _SelectExercisesPageState();
}

class _SelectExercisesPageState extends State<SelectExercisesPage> {
  final AthleteServices apiService =
      AthleteServices(baseUrl: ApiConfig.baseUrl);
  List<Exercise> _selectedExercises = []; // List to store selected exercises
  late Future<List<Exercise>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = getExercises(); // Fetch exercises when the page loads
  }

  Future<List<Exercise>> getExercises() async {
    try {
      final exercisesData = await apiService.fecthAllExercisesData();
      if (exercisesData is List && exercisesData.isNotEmpty) {
        return exercisesData
            .map((exercise) => Exercise.fromJson(exercise))
            .toList();
      } else {
        return [];
      }
    } catch (ex) {
      print('Error fetching exercises: $ex');
      return [];
    }
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        // Save the session with selected exercises and date
        _saveTrainingSession(selectedDate);
      }
    });
  }

  void _saveTrainingSession(DateTime date) async {
    try {
      print('Selected Exercises: $_selectedExercises');
      print('Selected Date: $date');

      // Retrieve athlete ID from shared preferences
      final id = await SharedPreferencesHelper.getId();

      // Ensure that the ID is not null
      if (id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No athlete ID found')),
        );
        return;
      }

      // Create the custom program object with the athlete's ID
      Customprogram customProgram = Customprogram(
        name: "customOne",
        image: "image", // Assuming image is a string URL or path
        exercises: _selectedExercises,
        athlete: Athlete(
            id: id,
            age: 0,
            email: "",
            gender: "hamza",
            goal: "",
            height: 12,
            name: "",
            password: "",
            weight: 12), // Send the athlete ID here
        status: "Active", // Default status
      );
      print("This is the ID: $id");

      // Call your function to create the custom program on the backend
      await apiService.createCustomProgram(customProgram);

      // Return to the previous page
      Navigator.of(context).pop();
    } catch (e) {
      print('Error saving custom program: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save custom program: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Exercises'),
        actions: [
          IconButton(
            onPressed: _selectedExercises.isEmpty
                ? null
                : () {
                    _showDatePicker(); // Show date picker
                  },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: FutureBuilder<List<Exercise>>(
        future: _exercisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load exercises.'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final exercises = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return CardExercise(
                  exercise: exercise,
                  isSelected: _selectedExercises.contains(exercise),
                  onTap: () {
                    setState(() {
                      if (_selectedExercises.contains(exercise)) {
                        _selectedExercises.remove(exercise); // Deselect
                      } else {
                        _selectedExercises.add(exercise); // Select
                      }
                    });
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No exercises found.'));
          }
        },
      ),
    );
  }
}

// CardExercise widget to display individual exercises
class CardExercise extends StatelessWidget {
  final Exercise exercise;
  final bool isSelected;
  final VoidCallback onTap;

  const CardExercise({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          exercise.name ?? 'Exercise Name',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          exercise.description ?? 'Exercise Description',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (value) {
            onTap();
          },
          activeColor: Colors.purple,
        ),
        onTap: onTap,
      ),
    );
  }
}
