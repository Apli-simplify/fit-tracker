import 'package:client_flutter/helpers/shared_preferences_helper.dart';
import 'package:client_flutter/views/Home/AthleteHome/exercise_program_page.dart';
import 'package:client_flutter/views/Home/AthleteHome/programs_tab.dart';
import 'package:client_flutter/views/Home/home_page.dart';
import 'package:client_flutter/views/SignIn/login_view.dart';
import 'package:client_flutter/views/signUp/signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String?> _initialRoute;

  @override
  void initState() {
    super.initState();
    _initialRoute = _getInitialRoute();
  }

  Future<String?> _getInitialRoute() async {
    return await SharedPreferencesHelper.getToken() != null
        ? '/home'
        : '/login';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: _initialRoute,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Navigator(
              initialRoute: snapshot.data,
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case '/home':
                    return MaterialPageRoute(builder: (context) => HomePage());
                  case '/login':
                    return MaterialPageRoute(builder: (context) => LoginView());
                  case '/signup':
                    return MaterialPageRoute(
                        builder: (context) => SignUpView());
                  default:
                    return null;
                }
              },
            );
          }
        },
      ),
    );
  }
}
