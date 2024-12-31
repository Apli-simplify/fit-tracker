import 'package:flutter/material.dart';
import 'package:client_flutter/models/CustomProgram.dart';
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
  List<Exercise> _selectedExercises = [];
  late Future<List<Exercise>> _exercisesFuture;
  String? _imageUrl;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _exercisesFuture = getExercises();
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
        _saveTrainingSession(selectedDate);
      }
    });
  }

  void _saveTrainingSession(DateTime date) async {
    try {
      if (_titleController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please enter a title for the custom program')),
        );
        return;
      }

      Customprogram customProgram = Customprogram(
        id: 12,
        name: _titleController.text,
        image: _imageUrl ?? "image",
        exercises: _selectedExercises,
        status: "Inactive",
      );

      await apiService.createCustomProgram(customProgram);

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
                    _showDatePicker();
                  },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Program Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _imageUrl = value;
                });
              },
            ),
          ),
          if (_imageUrl != null && _imageUrl!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                _imageUrl!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            child: FutureBuilder<List<Exercise>>(
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
                              _selectedExercises.remove(exercise);
                            } else {
                              _selectedExercises.add(exercise);
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
          ),
        ],
      ),
    );
  }
}

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
