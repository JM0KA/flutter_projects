import 'package:flutter/material.dart';
import 'package:bread_bank/widgets/add_expense_modal_widget.dart';

class ExpenseHeaderWidget extends StatelessWidget {
  const ExpenseHeaderWidget({required this.category, super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(251, 255, 228, 1),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (BuildContext context) => const AddExpenseModalWidget(),
              );
            },
            child: Text(
              '+ Add Item',
              style: TextStyle(color: Color.fromRGBO(251, 255, 228, 1)),
            ),
          ),
        ],
      ),
    );
  }
}
