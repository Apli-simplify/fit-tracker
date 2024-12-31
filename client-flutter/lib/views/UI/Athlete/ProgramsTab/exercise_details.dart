import 'package:flutter/material.dart';
import 'package:client_flutter/models/Exercise.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async'; // For Timer

class ExerciseDetails extends StatefulWidget {
  final Exercise exercise;

  const ExerciseDetails({required this.exercise, Key? key}) : super(key: key);

  @override
  _ExerciseDetailsState createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  bool isStarted = false;
  int remainingTime = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.exercise.duration ?? 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    if (remainingTime > 0) {
      print("Remaining time: ${_formatDuration(remainingTime)}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "You have to complete the exercise! Remaining time: ${_formatDuration(remainingTime)}"),
        ),
      );
    } else {
      print("Exercise completed!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Exercise completed!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.exercise.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailCard(
              icon: Icons.fitness_center,
              label: "Name",
              value: widget.exercise.name,
            ),
            const SizedBox(height: 10),
            _buildDetailCard(
              icon: Icons.place,
              label: "Target Area",
              value: widget.exercise.targetArea ?? 'N/A',
            ),
            const SizedBox(height: 10),
            _buildDetailCard(
              icon: Icons.speed,
              label: "Difficulty",
              value: widget.exercise.difficulty ?? 'N/A',
            ),
            const SizedBox(height: 10),
            _buildDetailCard(
              icon: Icons.description,
              label: "Description",
              value: widget.exercise.description ?? 'N/A',
            ),
            const SizedBox(height: 10),
            if (widget.exercise.duration != null)
              _buildDetailCard(
                icon: Icons.timer,
                label: "Duration",
                value: _formatDuration(widget.exercise.duration!),
              ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            _buildVideoUrlButton(widget.exercise.videoUrl),
            if (isStarted)
              Center(
                child: Text(
                  _formatDuration(remainingTime),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isStarted = !isStarted;
              if (isStarted) {
                _startTimer();
              } else {
                _stopTimer();
              }
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isStarted ? Colors.redAccent : Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isStarted ? Icons.stop : Icons.play_arrow,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                isStarted ? "Stop" : "Start",
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
      {required IconData icon, required String label, required String value}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoUrlButton(String videoUrl) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(videoUrl)) {
            await launch(videoUrl);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.video_library, color: Colors.black87),
              const SizedBox(width: 10),
              const Text(
                "Watch Video",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black87),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int durationInSeconds) {
    final int minutes = durationInSeconds ~/ 60;
    final int seconds = durationInSeconds % 60;
    return "$minutes minutes ${seconds > 0 ? '$seconds seconds' : ''}";
  }
}
