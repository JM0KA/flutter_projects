import 'package:bread_bank/managers/expense_db_manager.dart';
import 'package:bread_bank/models/expense_db_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpenseProvider extends ChangeNotifier {
  List<DbExpense> _expenses = [];

  List<DbExpense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenses = await ExpenseDbManager.instance.getExpenses();
    notifyListeners();
  }

  final Map<String, List<DbExpense>> _categoryExpenses = {};

  List<DbExpense> getCategoryExpenses(String category) =>
      _categoryExpenses[category] ?? [];

  Future<void> loadExpenseByCategory(String categoryType) async {
    final expenses = await ExpenseDbManager.instance.getExpensesByCategory(
      categoryType,
    );
    _categoryExpenses[categoryType] = expenses;
    notifyListeners();
  }

  double _expenseTotal = 0.0;

  Future<double> loadExpensesTotal() async {
    try {
      final total = await ExpenseDbManager.instance.getTotalExpenseAmount();
      _expenseTotal = total;
    } catch (e) {
      print(e);
      _expenseTotal = 0.0;
    }
    notifyListeners();

    return _expenseTotal;
  }

  double getExpensesTotal() {
    return _expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  final Map<String, double> _categoryTotals = {};

  double getTotalForCategory(String category) {
    return _expenses
        .where((expense) => expense.category == category)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  Future<double> loadCategoryTotal(String categoryType) async {
    try {
      final total = await ExpenseDbManager.instance.getCategoryTotalAmount(
        categoryType,
      );
      _categoryTotals[categoryType] = total;
    } catch (e) {
      print('Error loading category total: $e');
      _categoryTotals[categoryType] = 0.0;
    }
    notifyListeners();
    return _categoryTotals[categoryType]!;
  }

  Map<String, double> getTotalsForCategories() {
    final Map<String, double> totals = {};
    for (final expense in _expenses) {
      totals[expense.category] =
          (totals[expense.category] ?? 0) + expense.amount;
    }
    return totals;
  }

  Future<void> addExpense(DbExpense expense) async {
    try {
      await ExpenseDbManager.instance.insertExpense(expense);
      await loadExpenses();
      await loadCategoryTotal(expense.category);
      await loadExpenseByCategory(expense.category);
      notifyListeners();
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  Future<void> deleteExpense(int id, {String? categoryType}) async {
    try {
      await ExpenseDbManager.instance.deleteExpense(id);
      await loadExpenses();
      if (categoryType != null) {
        await loadExpenseByCategory(categoryType);
      }
    } catch (e) {
      print(e);
    }
  }
}
