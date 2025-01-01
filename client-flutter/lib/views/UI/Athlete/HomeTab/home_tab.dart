import 'package:flutter/material.dart';
import 'package:client_flutter/common_widget/Athlete_widgets/statistic_card.dart';

class HomeTab extends StatelessWidget {
  final VoidCallback onSeeMoreTap;

  const HomeTab({Key? key, required this.onSeeMoreTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: media.width * 0.05),
              const Text(
                "Activity Status",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: media.width * 0.02),
              _buildStatsGrid(media), // Use a grid for statistics
              SizedBox(height: media.width * 0.05),
              _buildWorkoutSection(media),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsGrid(Size media) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1, // Adjust the aspect ratio of the cards
      children: const [
        StatisticCard(
          label: "Calories Burned",
          value: "2000 kcal",
          icon: Icons.local_fire_department,
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        StatisticCard(
          label: "Steps Taken",
          value: "5000 steps",
          icon: Icons.directions_walk,
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        StatisticCard(
          label: "Workout Time",
          value: "45 mins",
          icon: Icons.timer,
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        StatisticCard(
          label: "Active Minutes",
          value: "30 mins",
          icon: Icons.fitness_center,
          gradient: LinearGradient(
            colors: [Colors.green, Colors.lightGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkoutSection(Size media) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Latest Workout",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: onSeeMoreTap,
              child: const Text(
                "See More",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
