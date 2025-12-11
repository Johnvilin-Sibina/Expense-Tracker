import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final double amount;
  final String category;
  final VoidCallback onDelete;

  const ExpenseCard({
    required this.title,
    required this.date,
    required this.amount,
    required this.category,
    required this.onDelete,
    super.key,
  });

  String get formattedDate => DateFormat("dd-MM-yyyy").format(date);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 6, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title + Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(formattedDate,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600])),
            ],
          ),

          // Amount Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo),
            ),
            child: Text(
              amount.toStringAsFixed(2),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.indigo),
            ),
          ),

          // Delete Button
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
    );
  }
}
