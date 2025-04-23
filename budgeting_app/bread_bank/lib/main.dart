import 'package:bread_bank/pages/expense_page.dart';
import 'package:bread_bank/pages/home_page.dart';
import 'package:bread_bank/pages/insights_page.dart';
import 'package:bread_bank/pages/goals_page.dart';
import 'package:bread_bank/pages/settings_page.dart';
import 'package:bread_bank/providers/expense_provider.dart';
import 'package:bread_bank/widgets/bottom_nav_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:bread_bank/routes.dart' as routes;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ExpenseProvider()..loadExpenses(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    HomePage(username: 'Justice'),
    ExpensePage(),
    InsightsPage(),
    GoalsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(61, 141, 122, 1),
      ),
      home: Scaffold(
        body: SafeArea(child: _pages[_currentIndex]),
        bottomNavigationBar: BottomNavWidget(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      routes: {
        routes.insightRoute: (context) => InsightsPage(),
        routes.goalsPageRoute: (context) => GoalsPage(),
        routes.settingsPageroute: (context) => SettingsPage(),
      },
    );
  }
}
