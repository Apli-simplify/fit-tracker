import 'package:client_flutter/views/UI/Athlete/HomeTab/home_tab.dart';
import 'package:client_flutter/views/UI/Athlete/MyPlansTab/my_plans.dart';
import 'package:client_flutter/views/UI/Athlete/ProfileTab/profile_tab.dart';
import 'package:client_flutter/views/UI/Athlete/ProgramsTab/programs_tab.dart';
import 'package:flutter/material.dart';
import 'package:client_flutter/common_widget/bottom_navigation.dart';

class HomePageAthlete extends StatefulWidget {
  final Map<String, dynamic> data;
  const HomePageAthlete({super.key, required this.data});

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
          HomeTab(onSeeMoreTap: () => _onItemTapped(1)),
          ProgramsTab(),
          MyPlansTab(),
          ProfileTab(
            data: widget.data,
          ),
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
            icon: Icon(Icons.list_alt),
            label: 'My Plans',
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
