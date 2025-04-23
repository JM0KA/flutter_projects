import 'package:bread_bank/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:bread_bank/widgets/expense_item_widget.dart';
import 'package:provider/provider.dart';

class DailyActivityWidget extends StatelessWidget {
  const DailyActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, child) {
        final expenses = expenseProvider.expenses.reversed.toList();

        return ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];

            return Dismissible(
              key: Key(expense.id?.toString() ?? '$index'),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await Provider.of<ExpenseProvider>(
                  context,
                  listen: false,
                ).deleteExpense(expense.id!);

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${expense.description} removed')),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 5,
                ),
                child: ExpenseItemWidget(
                  category: expense.category,
                  description: expense.description,
                  time: expense.time,
                  amount: expense.amount,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
