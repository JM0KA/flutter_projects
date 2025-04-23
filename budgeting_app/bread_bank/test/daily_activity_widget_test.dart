import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:bread_bank/models/expense_db_model.dart';
import 'package:bread_bank/providers/expense_provider.dart';
import 'package:bread_bank/widgets/daily_activity_widget.dart';

class FakeExpenseProvider extends ChangeNotifier implements ExpenseProvider {
  final List<DbExpense> _items = [
    DbExpense(
      id: 1,
      category: 'groceries',
      description: 'Sobeys',
      time: TimeOfDay(hour: 9, minute: 0),
      amount: 113.54,
    ),
    DbExpense(
      id: 2,
      category: 'car',
      description: 'Detailing',
      time: TimeOfDay(hour: 12, minute: 35),
      amount: 125.76,
    ),
  ];

  @override
  List<DbExpense> get expenses => _items;

  @override
  Future<void> loadExpenses() async {}

  @override
  Future<void> loadExpenseByCategory(String category) async {}

  @override
  Future<void> deleteExpense(int id, {String? categoryType}) async {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  @override
  Future<void> addExpense(DbExpense expense) async {}

  @override
  List<DbExpense> getCategoryExpenses(String category) {
    return <DbExpense>[];
  }

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
  testWidgets('DailyActivityWidget shows and dismisses items', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ExpenseProvider>.value(
        value: FakeExpenseProvider(),
        child: const MaterialApp(home: Scaffold(body: DailyActivityWidget())),
      ),
    );

    await tester.pumpAndSettle();

    // Expect 2 Dismissibles; (1) Sobeys and (2) Detailing
    expect(find.byType(Dismissible), findsNWidgets(2));
    expect(find.text('Sobeys'), findsOneWidget);
    expect(find.text('Detailing'), findsOneWidget);

    // Swipe the first item to dismiss
    final firstDismissible = find.byKey(const Key('1')).first;
    expect(firstDismissible, findsOneWidget);

    await tester.drag(firstDismissible, const Offset(-400, 0));
    await tester.pumpAndSettle();

    // Sobeys should be gone and Detailing should remain
    expect(find.text('Sobeys'), findsNothing);
    expect(find.text('Detailing'), findsOneWidget);

    // Should only be one dismissible left in ListView
    final listView = find.byType(ListView);
    final expenseTiles = find.descendant(
      of: listView,
      matching: find.byType(Dismissible),
    );

    expect(expenseTiles, findsOneWidget);
  });
}
