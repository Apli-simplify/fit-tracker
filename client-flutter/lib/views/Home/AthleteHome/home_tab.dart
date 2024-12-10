import 'package:client_flutter/views/Home/AthleteHome/programs_tab.dart';
import 'package:flutter/material.dart';
import 'package:client_flutter/common_widget/Athlete_widgets/statistic_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
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
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: media.width * 0.02),
              _buildStatsCard(media),
              SizedBox(height: media.width * 0.05),
              _buildWorkoutSection(context, media),
              ProgramsTab()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(Size media) {
    return Column(
      children: [
        StatisticCard(
            label: "Calories Burned", value: "2000 kcal", media: media),
        SizedBox(height: media.width * 0.05),
        StatisticCard(label: "Steps Taken", value: "5000 steps", media: media),
        SizedBox(height: media.width * 0.05),
        StatisticCard(label: "Workout Time", value: "45 mins", media: media),
        SizedBox(height: media.width * 0.05),
        StatisticCard(label: "Active Minutes", value: "30 mins", media: media),
      ],
    );
  }

  Widget _buildWorkoutSection(BuildContext context, Size media) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Latest Workout",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/programs');
          },
          child: const Text(
            "See More",
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
