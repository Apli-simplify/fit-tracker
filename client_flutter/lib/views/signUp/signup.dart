import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/common_widget/round_button.dart';
import 'package:client_flutter/common_widget/round_textfield.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/views/SignIn/login_view.dart';
import 'package:client_flutter/views/signUp/complete_profile.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  // Controllers to gather input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<String> list = <String>['Athlete', 'Trainer'];
  String dropdownValue = 'Athlete';

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
    Map<String, String> data = {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    print(dropdownValue);
    if (dropdownValue == "Trainer") {
      data["isAthlete"] = "false";
      final response = await widget.apiService.signup(data);
      print(response);
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
                    DropdownMenu<String>(
                      initialSelection: list.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      dropdownMenuEntries:
                          list.map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
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
