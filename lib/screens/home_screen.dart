import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/widgets/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final expensesBox = Hive.box<ExpenseModel>('expensesBox');

  List<ExpenseModel> get expenses {
    return expensesBox.values.toList();
  }

  final double totalAmount = 10000.0;

  double get totalExpenses {
    return expenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  double get balance {
    return totalAmount - totalExpenses;
  }

  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this record?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                expensesBox.deleteAt(index);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newExpense = await Navigator.pushNamed(context, "/add-expense")
              as ExpenseModel;
          setState(() {
            expensesBox.add(newExpense);
          });
        },
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        centerTitle: true,
        title: Text("Expense Tracker",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          // Summary Card
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                summaryLine("Total Amount", "Rs. ${totalAmount.toStringAsFixed(2)}", Colors.black),
                summaryLine("Your Expenses", "Rs. ${totalExpenses.toStringAsFixed(2)}", Colors.red),
                summaryLine(
                  "Balance",
                  "Rs. ${balance.toStringAsFixed(2)}",
                  balance >= 0 ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),

          // Expense List 
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final e = expenses[index];
                return ExpenseCard(
                  title: e.title,
                  amount: e.amount,
                  date: e.date,
                  category: e.category,
                  onDelete: () => confirmDelete(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for summary section
  Widget summaryLine(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
