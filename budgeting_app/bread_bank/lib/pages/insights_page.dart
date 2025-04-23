import 'package:flutter/material.dart';
import 'package:bread_bank/routes.dart' as routes;

class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  String data = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Insights',
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
            Text('Insights Page'),
            ElevatedButton(
              onPressed: () async {
                var retVal = await Navigator.of(
                  context,
                ).pushNamed(routes.settingsPageroute);
                if (retVal != null) {
                  setState(() {
                    data = retVal as String;
                  });
                }
              },
              child: Text('Go To Settings'),
            ),
            if (data.isNotEmpty) Text(data),
          ],
        ),
      ),
    );
  }
}
