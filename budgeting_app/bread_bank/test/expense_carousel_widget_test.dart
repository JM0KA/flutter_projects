import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:bread_bank/providers/expense_provider.dart';
import 'package:bread_bank/widgets/expense_carousel_widget.dart';
import 'package:bread_bank/models/expense_db_model.dart';

class FakeExpenseProvider extends ChangeNotifier implements ExpenseProvider {
  @override
  double getTotalForCategory(String category) => 0.0;

  @override
  Future<void> loadExpenseByCategory(String category) async {}

  @override
  List<DbExpense> get expenses => [];

  @override
  Future<void> loadExpenses() async {}

  @override
  Future<void> deleteExpense(int id, {String? categoryType}) async {}

  @override
  Future<void> addExpense(DbExpense expense) async {}

  @override
  List<DbExpense> getCategoryExpenses(String category) => [];

  @override
  double getExpensesTotal() => 0.0;

  @override
  Future<double> loadCategoryTotal(String categoryType) async => 0.0;

  @override
  Future<double> loadExpensesTotal() async => 0.0;

  @override
  Map<String, double> getTotalsForCategories() => {};
}

void main() {
  testWidgets('Expense carousel renders all slides and allows swiping', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ExpenseProvider>.value(
        value: FakeExpenseProvider(),
        child: const MaterialApp(home: Scaffold(body: ExpenseCarouselWidget())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Groceries'), findsOneWidget);

    final slider = find.byType(CarouselSlider);
    expect(slider, findsOneWidget);

    await tester.drag(slider, const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.text('Utilities'), findsOneWidget);

    await tester.drag(slider, const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsOneWidget);

    await tester.drag(slider, const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.text('Vehicle'), findsOneWidget);

    await tester.drag(slider, const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.text('Entertainment'), findsOneWidget);

    await tester.drag(slider, const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.text('Other'), findsOneWidget);
  });
}
