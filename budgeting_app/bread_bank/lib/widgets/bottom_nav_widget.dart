import 'package:flutter/material.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/home_icon.png', height: 30, width: 30, key: const Key('home_nav_icon'),),
          label: 'Home',
          backgroundColor: Color.fromRGBO(61, 141, 122, 1),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/expense_icon.png', height: 30, width: 30, key: const Key('expense_nav_icon'),),
          label: 'Expenses',
          backgroundColor: Color.fromRGBO(61, 141, 122, 1),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/insights_icon.png', height: 30, width: 30, key: const Key('insights_nav_icon'),),
          label: 'Insights',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/goals_icon.png', height: 30, width: 30, key: const Key('goals_nav_icon'),),
          label: 'Goals',
        ),
      ],
    );
  }
}
