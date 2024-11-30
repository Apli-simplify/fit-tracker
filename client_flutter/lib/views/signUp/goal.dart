import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/common_widget/round_button.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/views/SignIn/login_view.dart';
import 'package:flutter/material.dart';

class GoalView extends StatefulWidget {
  final Map<String, String> data;
  const GoalView({super.key, required this.data});
  @override
  State<GoalView> createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  CarouselController buttonCarouselController = CarouselController();
  String selectedGoalTitle = "";
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);

  @override
  void initState() {
    super.initState();
    if (goalArr.isNotEmpty) {
      selectedGoalTitle = goalArr[0]["title"].toString();
    }
  }

  Future<void> continueRegistration() async {
    try {
      if (selectedGoalTitle == null || selectedGoalTitle.isEmpty) {
        throw Exception("No goal selected. Please choose a goal.");
      }

      print("Selected Goal: $selectedGoalTitle");

      const improveShape = "IMPROVE_SHAPE";
      const leanAndTone = "LEAN_AND_TONE";
      const loseFat = "LOSE_FAT";

      String goal = "";

      switch (selectedGoalTitle) {
        case "Improve Shape":
          goal = improveShape;
          break;
        case "Lean & Tone":
          goal = leanAndTone;
          break;
        case "Lose a Fat":
          goal = loseFat;
          break;
        default:
          throw Exception("Invalid goal selected.");
      }

      widget.data["goal"] = goal;
      try {
        final response = await apiService.signup(widget.data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } catch (e) {
      print("Error: $e");

      // Show a SnackBar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign-up failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  List goalArr = [
    {
      "image": "assets/img/goal_1.png",
      "title": "Improve Shape",
      "subtitle":
          "I have a low amount of body fat\nand need / want to build more\nmuscle"
    },
    {
      "image": "assets/img/goal_2.png",
      "title": "Lean & Tone",
      "subtitle":
          "I’m “skinny fat”. look thin but have\nno shape. I want to add lean\nmuscle in the right way"
    },
    {
      "image": "assets/img/goal_3.png",
      "title": "Lose a Fat",
      "subtitle":
          "I have over 20 lbs to lose. I want to\ndrop all this fat and gain muscle\nmass"
    },
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: CarouselSlider(
                items: goalArr
                    .map(
                      (gObj) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGoalTitle = gObj["title"].toString();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: TColor.primaryG,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: media.width * 0.1,
                            horizontal: 25,
                          ),
                          alignment: Alignment.center,
                          child: FittedBox(
                            child: Column(
                              children: [
                                Image.asset(
                                  gObj["image"].toString(),
                                  width: media.width * 0.5,
                                  fit: BoxFit.fitWidth,
                                ),
                                SizedBox(height: media.width * 0.1),
                                Text(
                                  gObj["title"].toString(),
                                  style: TextStyle(
                                    color: TColor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  width: media.width * 0.1,
                                  height: 1,
                                  color: TColor.white,
                                ),
                                SizedBox(height: media.width * 0.02),
                                Text(
                                  gObj["subtitle"].toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: TColor.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  viewportFraction: 0.7,
                  aspectRatio: 0.74,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedGoalTitle = goalArr[index]["title"].toString();
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: media.width,
              child: Column(
                children: [
                  SizedBox(height: media.width * 0.05),
                  Text(
                    "What is your goal ?",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "It will help us to choose the best\nprogram for you",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.gray, fontSize: 12),
                  ),
                  const Spacer(),
                  SizedBox(height: media.width * 0.05),
                  RoundButton(
                      title: "Confirm", onPressed: continueRegistration),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
