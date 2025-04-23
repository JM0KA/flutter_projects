import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:bread_bank/models/expense_db_model.dart';
import 'package:bread_bank/providers/expense_provider.dart';
import 'package:bread_bank/widgets/expense_category_list_widget.dart';

class FakeExpenseProvider extends ChangeNotifier implements ExpenseProvider {
  final List<DbExpense> _items = [
    DbExpense(
      category: 'groceries',
      description: 'Costco',
      time: TimeOfDay(hour: 10, minute: 23),
      amount: 316.45,
    ),
    DbExpense(
      category: 'groceries',
      description: 'Super Store',
      time: TimeOfDay(hour: 14, minute: 53),
      amount: 135.24,
    ),
    DbExpense(
      category: 'car',
      description: 'Car Payment',
      time: TimeOfDay(hour: 8, minute: 30),
      amount: 225.35,
    ),
    DbExpense(
      category: 'utilities',
      description: 'Water Bill',
      time: TimeOfDay(hour: 9, minute: 25),
      amount: 125.66,
    ),
  ];

  @override
  List<DbExpense> get expenses => _items;

  @override
  Future<void> loadExpenses() async {}

  @override
  Future<void> deleteExpense(int id, {String? categoryType}) async {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  @override
  Future<void> addExpense(DbExpense expense) async {}

  @override
  List<DbExpense> getCategoryExpenses(String category) {
    return _items.where((expense) => expense.category == category).toList();
  }

  @override
  Future<void> loadExpenseByCategory(String category) async {}

  @override
  double getExpensesTotal() => 0.0;

  @override
  double getTotalForCategory(String category) => 0.0;

  @override
  Future<double> loadCategoryTotal(String categoryType) async => 0.0;

  @override
  Future<double> loadExpensesTotal() async => 0.0;
  
  @override
  Map<String, double> getTotalsForCategories() => {};
}

void main() {
  group('Expense Category List Widget Tests', () {
    testWidgets('displays a list of grocerues when provder has them', (
      tester,
    ) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<ExpenseProvider>.value(
          value: FakeExpenseProvider(),
          child: const MaterialApp(
            home: Scaffold(
              body: ExpenseCategoryListWidget(categoryType: 'groceries'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 2 Dismissibles should be found
      expect(find.byType(Dismissible), findsNWidgets(2));

      // Grocery Expenses should appear with description
      expect(find.text('Costco'), findsOneWidget);
      expect(find.text('Super Store'), findsOneWidget);

      // 'No Expenses' message should NOT appear
      expect(find.text('No Expenses for Groceries'), findsNothing);
    });

    testWidgets('Displays empty state when no Expesens for that Category', (
      tester,
    ) async {
      final fake = FakeExpenseProvider();

      await tester.pumpWidget(
        ChangeNotifierProvider<ExpenseProvider>.value(
          value: fake,
          child: const MaterialApp(
            home: Scaffold(
              body: ExpenseCategoryListWidget(categoryType: 'other'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // No Dismissibles
      expect(find.byType(Dismissible), findsNothing);

      // Empty Expense message appears
      expect(find.text('No Expenses for Other'), findsOneWidget);
    });
  });
}
