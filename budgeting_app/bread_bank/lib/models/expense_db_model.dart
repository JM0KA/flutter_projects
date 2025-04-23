import 'package:flutter/material.dart';

class DbExpense {
  final int? id;
  final String category;
  final String description;
  final TimeOfDay time;
  final double amount;

  const DbExpense({
    this.id,
    required this.category,
    required this.description,
    required this.time,
    required this.amount,
  });

  String _timeToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  Map<String, Object?> toMap() {
    return {
      if (id != null) 'id': id,
      'category': category,
      'description': description,
      'time': _timeToString(time),
      'amount': amount,
    };
  }

  factory DbExpense.fromMap(Map<String, Object?> expenseMap) {
    final timeString = expenseMap['time']?.toString() ?? '00:00';

    final parts = timeString.split(':');
    if (parts.length != 2) {
      return DbExpense(
        id: expenseMap['id'] as int?,
        category: expenseMap['category'] as String,
        description: expenseMap['description'] as String,
        time: const TimeOfDay(hour: 0, minute: 0),
        amount: expenseMap['amount'] as double,
      );
    }

    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;

    return DbExpense(
      id: expenseMap['id'] as int?,
      category: expenseMap['category'] as String,
      description: expenseMap['description'] as String,
      time: TimeOfDay(hour: hour, minute: minute),
      amount: expenseMap['amount'] as double,
    );
  }
}
