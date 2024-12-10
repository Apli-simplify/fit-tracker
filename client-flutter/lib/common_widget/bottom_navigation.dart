import 'package:flutter/material.dart';
import 'package:client_flutter/common/colo_extension.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemTapped,
      items: items,
      selectedItemColor: TColor.primaryColor1,
      unselectedItemColor: Colors.grey,
    );
  }
}
