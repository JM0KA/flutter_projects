import 'package:flutter/material.dart';

class AccountBalanceWidget extends StatefulWidget {
  const AccountBalanceWidget({required this.balance, super.key});
  final double balance;

  @override
  State<AccountBalanceWidget> createState() => _AccountBalanceWidgetState();
}

class _AccountBalanceWidgetState extends State<AccountBalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 150,
      padding: EdgeInsets.only(left: 20, top: 30),
      decoration: BoxDecoration(
        color: Color.fromRGBO(251, 255, 228, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Budget',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '\$${widget.balance.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '\t\tremaining',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
