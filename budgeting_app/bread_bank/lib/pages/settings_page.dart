import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Settings',
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
                Navigator.of(context).pop('You left the Settings');
              },
              child: Text('Go back to the Insights page'),
            ),
          ],
        ),
      ),
    );
  }
}
