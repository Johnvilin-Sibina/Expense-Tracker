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
      home: const AddExpense(),
    );
  }
}

class ExpenseHome extends StatelessWidget {
  const ExpenseHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Tracker")),
      body: ExpenseCard(
        title: "Groceries",
        date: "Sep 15, 2025",
        amount: 250.00,
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final String title;
  final String date;
  final double amount;

  const ExpenseCard({
    required this.title,
    required this.date,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(30.0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  date,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
              child: Text(
                amount.toStringAsFixed(2),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  void showDatepicker() async{
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    print("Selected Date $pickedDate");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(labelText: "Title")),
              TextFormField(
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
              ),
              TextButton(onPressed: showDatepicker, child: Text("Choose Date")),
              SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text("Add Expense")),
            ],
          ),
        ),
      ),
    );
  }
}
