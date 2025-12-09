import 'package:expense_tracker/screens/add_expense_screen.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const HomeScreen(),
      routes: {
        "/" : (context) => const HomeScreen(),
        "/add-expense" : (context) => AddExpenseScreen(),
      },
    );
  }
}
