import 'package:flutter/material.dart';

class ComparisonWidget extends StatefulWidget {
  const ComparisonWidget({
    required this.compType,
    required this.totalExpenses,
    super.key,
  });

  final double totalExpenses;
  final String compType;

  @override
  State<ComparisonWidget> createState() => _ComparisonWidgetState();
}

class _ComparisonWidgetState extends State<ComparisonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromRGBO(179, 216, 168, 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.compType,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  '\$${widget.totalExpenses.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
