import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import 'package:bread_bank/providers/expense_provider.dart';

class ExpensePieChart extends StatefulWidget {
  const ExpensePieChart({super.key});

  @override
  State<ExpensePieChart> createState() => _ExpensePieChartState();
}

class _ExpensePieChartState extends State<ExpensePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, _) {
        final totals = provider.getTotalsForCategories();
        final categories = <String>[
          'groceries',
          'utilities',
          'car',
          'home',
          'entertainment',
          'other',
        ];

        final catsWithData =
            categories
                .where((category) => (totals[category] ?? 0) > 0)
                .toList();

        final sections = <PieChartSectionData>[];
        for (var i = 0; i < catsWithData.length; i++) {
          final category = catsWithData[i];
          final value = totals[category]!;

          final isTouched = (i == touchedIndex);
          final radius = isTouched ? 125.0 : 110.0;
          final badgeSize = isTouched ? 50.0 : 40.0;

          sections.add(
            PieChartSectionData(
              color: _colourFor(category),
              value: value,
              title: '',
              radius: radius,
              badgeWidget: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/${_iconFor(category)}.png',
                  width: badgeSize,
                  height: badgeSize,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }
        return AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 40,
              sections: sections,
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _iconFor(String category) {
    switch (category) {
      case 'groceries':
        return 'grocery_icon';
      case 'utilities':
        return 'utilities_icon';
      case 'car':
        return 'car_icon';
      case 'home':
        return 'home_icon';
      case 'entertainment':
        return 'entertainment_icon';
      case 'other':
        return 'other_icon';
      default:
        return 'default_icon';
    }
  }

  Color _colourFor(String category) {
    switch (category) {
      case 'groceries':
        return Color.fromRGBO(192, 199, 140, 1);
      case 'utilities':
        return Color.fromRGBO(166, 179, 125, 1);
      case 'car':
        return Color.fromRGBO(185, 148, 112, 1);
      case 'home':
        return Color.fromRGBO(112, 109, 84, 1);
      case 'entertainment':
        return Color.fromRGBO(119, 136, 103, 1);
      case 'other':
        return Color.fromRGBO(140, 120, 90, 1);
      default:
        return Colors.grey;
    }
  }
}
