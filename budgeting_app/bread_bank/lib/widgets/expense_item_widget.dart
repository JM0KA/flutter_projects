import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatefulWidget {
  const ExpenseItemWidget({
    required this.category,
    required this.description,
    required this.time,
    required this.amount,
    super.key,
  });

  final String category;
  final String description;
  final TimeOfDay time;
  final double amount;

  @override
  State<ExpenseItemWidget> createState() => _ExpenseItemWidgetState();
}

class _ExpenseItemWidgetState extends State<ExpenseItemWidget> {
  Map<String, String> categoryIcons = {
    'groceries': 'grocery_icon',
    'utilities': 'utilities_icon',
    'home': 'home_icon',
    'car': 'car_icon',
    'restaurant': 'restaurant_icon',
    'entertainment': 'entertainment_icon',
    'other': 'other_icon',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 380,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromRGBO(251, 255, 228, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/${categoryIcons[widget.category] ?? 'default_icon'}.png',
                color: Colors.black,
                height: 50,
                width: 50,
              ),
            ],
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.description,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text(
                  widget.time.format(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            '-\$${widget.amount.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
