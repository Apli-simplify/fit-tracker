import 'package:client_flutter/views/Home/AthleteHome/home_tab.dart';
import 'package:client_flutter/views/Home/AthleteHome/profile_tab.dart';
import 'package:client_flutter/views/Home/AthleteHome/programs_tab.dart';
import 'package:flutter/material.dart';
import 'package:client_flutter/common_widget/bottom_navigation.dart';

class HomePageAthlete extends StatefulWidget {
  final Map<String, dynamic> data;
  HomePageAthlete({Key? key, required this.data}) : super(key: key);

  @override
  State<HomePageAthlete> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomePageAthlete> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          HomeTab(),
          ProgramsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onItemTapped: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Programs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
