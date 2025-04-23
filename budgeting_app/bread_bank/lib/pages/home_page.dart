import 'package:bread_bank/widgets/expense_carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:bread_bank/widgets/account_balance_widget.dart';
import 'package:bread_bank/widgets/daily_activity_widget.dart';
import 'package:bread_bank/widgets/expense_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.username, super.key});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 5)),
                const Text(
                  'Welcome back,',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(251, 255, 228, 1),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 5)),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(251, 255, 228, 1),
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor: Color.fromRGBO(61, 141, 122, 1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            spacing: 10,
            children: [
              AccountBalanceWidget(balance: 1737.67),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ExpenseHeaderWidget(category: 'Expenses'),
              ),
              ExpenseCarouselWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      'Today\'s Activty',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(251, 255, 228, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 335, child: DailyActivityWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
