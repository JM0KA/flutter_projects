import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bread_bank/providers/expense_provider.dart';
import 'package:bread_bank/widgets/expense_item_widget.dart';

class ExpenseCategoryListWidget extends StatefulWidget {
  const ExpenseCategoryListWidget({required this.categoryType, super.key});

  final String categoryType;

  @override
  State<ExpenseCategoryListWidget> createState() =>
      _ExpenseCategoryListWidgetState();
}

class _ExpenseCategoryListWidgetState extends State<ExpenseCategoryListWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseProvider>(
      context,
      listen: false,
    ).loadExpenseByCategory(widget.categoryType);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, child) {
        final expenses =
            expenseProvider
                .getCategoryExpenses(widget.categoryType)
                .reversed
                .toList();
        if (expenses.isEmpty) {
          return Column(
            children: [
              SizedBox(height: 70),
              Text(
                'No Expenses for ${widget.categoryType[0].toUpperCase() + widget.categoryType.substring(1)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromRGBO(251, 255, 228, 1),
                ),
              ),
            ],
          );
        }

        return ListView.builder(
          shrinkWrap: true,
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
                Provider.of<ExpenseProvider>(
                  context,
                  listen: false,
                ).deleteExpense(expense.id!, categoryType: widget.categoryType);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${expense.description} removed')),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
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
