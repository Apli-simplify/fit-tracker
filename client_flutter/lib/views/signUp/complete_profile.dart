import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/common_widget/round_icon_button.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/views/signUp/goal.dart';
import 'package:flutter/material.dart';

import '../../../common_widget/round_button.dart';
import '../../../common_widget/round_textfield.dart';

class CompleteProfileView extends StatefulWidget {
  final Map<String, String> data;
  const CompleteProfileView({super.key, required this.data});
  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController birthDateController = TextEditingController();
  String? gender;
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void continueRegistration() async {
    if (gender == null ||
        birthDateController.text.isEmpty ||
        heightController.text.isEmpty ||
        weightController.text.isEmpty) {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required!")),
      );
      return;
    }
    widget.data["height"] = heightController.text;
    widget.data["weight"] = weightController.text;

    // sending request  :
    final response = await apiService.signup(widget.data);
    print(response);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const GoalView()));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date
      firstDate: DateTime(1900), // Earliest date
      lastDate: DateTime.now(), // Latest date
    );

    if (picked != null) {
      setState(() {
        birthDateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format to YYYY-MM-DD
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: TColor.lightGray,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                width: 50,
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset(
                                  "assets/img/gender.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  color: TColor.gray,
                                )),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  items: ["Male", "Female"]
                                      .map((name) => DropdownMenuItem(
                                            value: name,
                                            child: Text(
                                              name,
                                              style: TextStyle(
                                                  color: TColor.gray,
                                                  fontSize: 14),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                    "Choose Gender",
                                    style: TextStyle(
                                        color: TColor.gray, fontSize: 12),
                                  ),
                                  value: gender,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundIconButton(
                        controller: birthDateController,
                        hitText: "Date of Birth",
                        icon: "assets/img/date.png",
                        onTap: () {
                          _selectDate(context); // Open the date picker on tap
                        },
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              isNumeric: true,
                              controller: weightController,
                              hitText: "Your Weight",
                              icon: "assets/img/weight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.secondaryG,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "KG",
                              style:
                                  TextStyle(color: TColor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              isNumeric: true,
                              controller: heightController,
                              hitText: "Your Height",
                              icon: "assets/img/hight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.secondaryG,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "CM",
                              style:
                                  TextStyle(color: TColor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      RoundButton(
                          title: "Next >", onPressed: continueRegistration),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
