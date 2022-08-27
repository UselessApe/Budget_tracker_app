import 'package:flutter/material.dart';

class BudgetHistoryPage extends StatelessWidget {
  const BudgetHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'BudgetHistoryPage is working',
          style: TextStyle(fontSize: 20),
        ),
        //TODO implement List of Budgets set before on monthly base
      ),
    );
  }
}
