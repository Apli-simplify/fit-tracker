import 'package:client_flutter/common/colo_extension.dart';
import 'package:client_flutter/common_widget/round_button.dart';
import 'package:client_flutter/common_widget/round_textfield.dart';
import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/services/api_config.dart';
import 'package:client_flutter/services/api_services.dart';
import 'package:client_flutter/views/Home/home_page.dart';
import 'package:client_flutter/views/signUp/signup.dart';
import 'package:flutter/material.dart';

class PasswordView extends StatefulWidget {
  TextEditingController email;
  PasswordView({super.key, required this.email});
  final ApiService apiService = ApiService(baseUrl: ApiConfig.baseUrl);

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    try {
      if (widget.email.text.isNotEmpty && passwordController.text.isNotEmpty) {
        final response = await widget.apiService
            .login(widget.email.text, passwordController.text);
        print(response);
        if (response['access_token'] != null) {
          SharedPreferencesHelper.saveToken(
              response['access_token'], response['refresh_token']);
          Navigator.pushNamed(context, '/home');
        } else {
          throw Exception('Login failed');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter both email and password'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Login failed: $e'),
      ));
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
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: media.height * 0.05,
                ),
                RoundTextField(
                  hitText: "Enter password",
                  icon: "assets/img/lock.png",
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscureText: true,
                ),
                SizedBox(
                  height: media.height * 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: null,
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.height * 0.1,
                ),
                RoundButton(title: "Sign In", onPressed: _login),
                SizedBox(
                  height: media.height * 0.02,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don’t have an account yet? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Register",
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
    );
  }
}
