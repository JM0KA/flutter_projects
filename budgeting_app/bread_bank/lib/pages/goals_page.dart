import 'package:flutter/material.dart';
import 'package:bread_bank/routes.dart' as routes;

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Goals',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(251, 255, 228, 1),
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor: Color.fromRGBO(61, 141, 122, 1),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Goals Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(routes.insightRoute);
              },
              child: Text('Go to Insights'),
            ),
          ],
        ),
      ),
    );
  }
}
