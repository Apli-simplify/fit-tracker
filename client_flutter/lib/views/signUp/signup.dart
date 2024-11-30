import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/common_widget/round_button.dart';
import 'package:client_flutter/common_widget/round_textfield.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/views/SignIn/login_view.dart';
import 'package:client_flutter/views/signUp/Athlete/complete_profile.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> list = <String>['Athlete', 'Trainer'];

  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  final RegExp passwordRegex = RegExp(r'[a-zA-Z0-9]{5,}');

  String? dropdownValue;
  String? gender;
  bool isCheck = false;
  void continueRegistration() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    //regex validation
    if (_emailController.text.isNotEmpty &&
        !emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid email address."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text.isNotEmpty &&
        !passwordRegex.hasMatch(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid password ."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Map<String, String> data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "gender": gender!
    };
    if (dropdownValue == "Trainer") {
      data["isAthlete"] = "false";

      try {
        final response = await widget.apiService.signup(data);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response['message']),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
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
    } else {
      data["isAthlete"] = "true";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CompleteProfileView(data: data),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: TColor.gray)),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: media.height - MediaQuery.of(context).padding.top,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create an Account",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: media.width * 0.05),
                    RoundTextField(
                      hitText: "Name",
                      icon: "assets/img/user_text.png",
                      controller: _nameController,
                    ),
                    SizedBox(height: media.width * 0.04),
                    RoundTextField(
                      hitText: "Email",
                      icon: "assets/img/email.png",
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    SizedBox(height: media.width * 0.04),
                    RoundTextField(
                      hitText: "Password",
                      icon: "assets/img/lock.png",
                      obscureText: true,
                      controller: _passwordController,
                      rigtIcon: TextButton(
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            "assets/img/show_password.png",
                            width: 20,
                            height: 20,
                            fit: BoxFit.contain,
                            color: TColor.gray,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),
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
                                items: ["Athlete", "Trainer"]
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
                                    dropdownValue = value;
                                  });
                                },
                                isExpanded: true,
                                hint: Text(
                                  "Choose Type",
                                  style: TextStyle(
                                      color: TColor.gray, fontSize: 12),
                                ),
                                value: dropdownValue,
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
                      height: media.width * 0.05,
                    ),
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
                                items: ["MALE", "FEMALE"]
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
                                  "Choose gender",
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
                    SizedBox(height: media.width * 0.1),
                    RoundButton(
                      title: "Register",
                      onPressed: continueRegistration,
                    ),
                    SizedBox(height: media.width * 0.04),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
