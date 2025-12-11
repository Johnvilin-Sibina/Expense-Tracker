import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final List<String> _categories = [
    "Food",
    "Travel",
    "Shopping",
    "Bills",
    "Health",
    "Entertainment",
    "Other",
  ];

  String? _selectedCategory;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();

  void showDatepicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void submitForm() {
    if ((_formKey.currentState?.validate() ?? false) && _selectedDate != null && _selectedCategory != null) {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);

      final newExpense = ExpenseModel(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      );
      Navigator.pop(context, newExpense);
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedDate = null;
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense"), elevation: 1),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 450, 
            padding: const EdgeInsets.all(20),
          
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
          
              child: Padding(
                padding: const EdgeInsets.all(24.0),
          
                child: Form(
                  key: _formKey,
          
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
          
                    children: [
                      const Text(
                        "Add New Expense",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
          
                      const SizedBox(height: 25),
          
                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a title";
                          }
                          return null;
                        },
                      ),
          
                      const SizedBox(height: 20),
          
                      // Amount
                      TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an amount";
                          }
                          if (double.tryParse(value) == null) {
                            return "Enter a valid number";
                          }
                          if (double.parse(value) <= 0) {
                            return "Amount must be greater than zero";
                          }
                          return null;
                        },
                      ),
          
                      const SizedBox(height: 20),
          
                      // Category Dropdown
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Category",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        initialValue: _selectedCategory,
                        items: _categories.map((cat) {
                          return DropdownMenuItem(value: cat, child: Text(cat));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please select a category";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
          
                      // Date Picker
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedDate == null
                                ? "No date chosen!"
                                : "Picked: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          TextButton(
                            onPressed: showDatepicker,
                            child: const Text(
                              "Choose Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
          
                      const SizedBox(height: 30),
          
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Add Expense"),
                          ),
          
                          const SizedBox(width: 20),
          
                          OutlinedButton(
                            onPressed: resetForm,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Reset"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
