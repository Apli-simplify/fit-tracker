import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/views/Home/AthleteHome/programs_tab.dart';
import 'package:client_flutter/views/Home/home_page.dart';
import 'package:client_flutter/views/SignIn/login_view.dart';
import 'package:client_flutter/views/signUp/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute:
          // ignore: unnecessary_null_comparison
          SharedPreferencesHelper.getToken() != null ? '/home' : '/login',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginView(),
        '/signup': (context) => SignUpView(),
      },
    );
  }
}
