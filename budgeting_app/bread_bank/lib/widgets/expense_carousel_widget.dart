import 'package:flutter/material.dart';
import 'package:bread_bank/widgets/expense_category_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ExpenseCarouselWidget extends StatelessWidget {
  const ExpenseCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'category': 'groceries', 'description': 'Groceries'},
      {'category': 'utilities', 'description': 'Utilities'},
      {'category': 'home', 'description': 'Home'},
      {'category': 'car', 'description': 'Vehicle'},
      {'category': 'entertainment', 'description': 'Entertainment'},
      {'category': 'other', 'description': 'Other'},
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 110,
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 0.325,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items:
          categories.map((category) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ExpenseCategoryWidget(
                category: category['category']!,
                description: category['description']!,
              ),
            );
          }).toList(),
    );
  }
}
