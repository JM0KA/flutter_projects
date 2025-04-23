import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bread_bank/providers/expense_provider.dart';

class ExpenseCategoryWidget extends StatefulWidget {
  const ExpenseCategoryWidget({
    required this.category,
    required this.description,
    super.key,
  });

  final String category;
  final String description;

  @override
  State<ExpenseCategoryWidget> createState() => _ExpenseCategoryWidgetState();
}

class _ExpenseCategoryWidgetState extends State<ExpenseCategoryWidget> {
  Map<String, String> categoryIcons = {
    'groceries': 'grocery_icon',
    'utilities': 'utilities_icon',
    'home': 'home_icon',
    'car': 'car_icon',
    'restaurant': 'restaurant_icon',
    'entertainment': 'entertainment_icon',
    'other': 'other_icon',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, child) {
        final double totalAmount = expenseProvider.getTotalForCategory(
          widget.category,
        );

        return Container(
          height: 125,
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Color.fromRGBO(179, 216, 168, 1),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/${categoryIcons[widget.category] ?? 'default_icon'}.png',
                    color: Colors.black,
                    height: 30,
                    width: 30,
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '\$${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
