import 'package:bread_bank/models/expense_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpenseDbManager {
  const ExpenseDbManager._();

  static const ExpenseDbManager instance = ExpenseDbManager._();

  static const _dbName = 'expenses.db';
  static const _dbVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _connectToDB();
    return _database!;
  }

  Future<Database> _connectToDB() async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, _dbName);

    final db = openDatabase(
      path,
      onCreate: (database, version) {
        database.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT, description TEXT, time TEXT, amount REAL)',
        );
      },
      version: _dbVersion,
    );
    return db;
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }

  Future<void> insertExpense(DbExpense expense) async {
    final db = await database;
    await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DbExpense>> getExpenses() async {
    final db = await database;
    final expenseMaps = await db.query('expenses');

    return [
      for (final expenseMap in expenseMaps) DbExpense.fromMap(expenseMap),
    ];
  }

  Future<List<DbExpense>> getExpensesByCategory(String categoryType) async {
    final db = await database;
    final categoryMaps = await db.query(
      'expenses',
      columns: ['id', 'category', 'description', 'time', 'amount'],
      where: 'category = ?',
      whereArgs: [categoryType],
    );

    return [
      for (final categoryMap in categoryMaps) DbExpense.fromMap(categoryMap),
    ];
  }

  Future<double> getTotalExpenseAmount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) AS total FROM expenses',
    );

    final total = result.first['total'];

    return total != null ? (total as num).toDouble() : 0.0;
  }

  Future<double> getCategoryTotalAmount(String categoryType) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) AS total FROM expenses WHERE category = ?',
      [categoryType],
    );

    final total = result.first['total'];

    return total != null ? (total as num).toDouble() : 0.0;
  }

  Future<void> updateExpense(DbExpense expense) async {
    final db = await database;
    await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(int id) async {
    final db = await database;
    await db.delete('expenses', where: 'id = ?', whereArgs: [id]);
  }
}
