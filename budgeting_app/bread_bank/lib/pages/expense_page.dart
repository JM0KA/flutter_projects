import 'package:bread_bank/widgets/add_expense_modal_widget.dart';
import 'package:bread_bank/widgets/comparison_widget.dart';
import 'package:bread_bank/widgets/expense_category_list_widget.dart';
import 'package:bread_bank/widgets/expense_header_widget.dart';
import 'package:bread_bank/widgets/expense_pie_chart.dart';
import 'package:bread_bank/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(251, 255, 228, 1),
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: Color.fromRGBO(61, 141, 122, 1),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (BuildContext context) =>
                              const AddExpenseModalWidget(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(179, 216, 168, 1),
                    fixedSize: Size(380, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Add Expense +',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(251, 255, 228, 1),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: SizedBox(
                    height: 380,
                    width: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [ExpensePieChart()],
                    ),
                  ),
                ),
                Consumer<ExpenseProvider>(
                  builder: (context, expenseProvider, child) {
                    final total = expenseProvider.getExpensesTotal();
                    final formatted = total.toStringAsFixed(2);
                    return Row(
                      spacing: 25,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ComparisonWidget(
                          compType: 'Expenses',
                          totalExpenses: double.parse(formatted),
                        ),
                        ComparisonWidget(
                          compType: 'Budget',
                          totalExpenses: 4000,
                        ),
                      ],
                    );
                  },
                ),

                Column(
                  spacing: 10,
                  children: [
                    ExpenseHeaderWidget(category: 'Utilities'),
                    SizedBox(
                      height: 175,
                      child: ExpenseCategoryListWidget(
                        categoryType: 'utilities',
                      ),
                    ),

                    ExpenseHeaderWidget(category: 'Groceries'),
                    SizedBox(
                      height: 175,
                      child: ExpenseCategoryListWidget(
                        categoryType: 'groceries',
                      ),
                    ),

                    ExpenseHeaderWidget(category: 'Vehicle'),
                    SizedBox(
                      height: 175,
                      child: ExpenseCategoryListWidget(categoryType: 'car'),
                    ),

                    ExpenseHeaderWidget(category: 'House'),
                    SizedBox(
                      height: 175,
                      child: ExpenseCategoryListWidget(categoryType: 'home'),
                    ),

                    ExpenseHeaderWidget(category: 'Entertainment'),
                    SizedBox(
                      height: 175,
                      child: ExpenseCategoryListWidget(
                        categoryType: 'entertainment',
                      ),
                    ),

                    ExpenseHeaderWidget(category: 'Other'),
                    SizedBox(
                      height: 175,
                      child: ExpenseCategoryListWidget(categoryType: 'other'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
