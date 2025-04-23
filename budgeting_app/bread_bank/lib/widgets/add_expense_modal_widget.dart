import 'package:bread_bank/models/expense_db_model.dart';
import 'package:bread_bank/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpenseModalWidget extends StatefulWidget {
  const AddExpenseModalWidget({super.key});

  @override
  State<AddExpenseModalWidget> createState() => _AddExpenseModalWidgetState();
}

class _AddExpenseModalWidgetState extends State<AddExpenseModalWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _expenseDescription = '';
  double _expenseAmount = 0.0;
  String? _selectedCategory;

  final Map<String, String> _expenseCategory = {
    'Home': 'home',
    'Utilities': 'utilities',
    'Groceries': 'groceries',
    'Transportation': 'car',
    'Entertainment': 'entertainment',
    'Restaurant': 'restaurant',
    'Other': 'other',
  };

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final expense = DbExpense(
        category: _selectedCategory!,
        description: _expenseDescription,
        time: TimeOfDay.now(),
        amount: _expenseAmount,
      );

      await Provider.of<ExpenseProvider>(
        context,
        listen: false,
      ).addExpense(expense);

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromRGBO(251, 255, 228, 1),
      title: Text(
        'Add Expense',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Choose a Category',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  filled: false,
                ),
                value: _selectedCategory,
                items:
                    _expenseCategory.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.value,
                        child: Text(entry.key),
                      );
                    }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a Category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Expense Description',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  filled: false,
                ),
                onChanged: (value) {
                  setState(() {
                    _expenseDescription = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide expense description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                  labelText: 'Expense Amount',
                  labelStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  filled: false,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _expenseAmount = double.tryParse(value) ?? 0.0;
                  });
                },
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      double.tryParse(value) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromRGBO(253, 126, 137, 1),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromRGBO(179, 216, 168, 1),
                ),
              ),
              child: const Text(
                'Add Expense',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
