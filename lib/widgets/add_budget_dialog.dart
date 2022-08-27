import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddBudgetDialog extends StatefulWidget {
  final Function(double) budgetToAdd;

  const AddBudgetDialog({
    Key? key,
    required this.budgetToAdd,
  }) : super(key: key);

  @override
  State<AddBudgetDialog> createState() => _AddBudgetDialogState();
}

final TextEditingController budgetController = TextEditingController();

class _AddBudgetDialogState extends State<AddBudgetDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add Budget",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: "Budget in \$"),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (budgetController.text.isNotEmpty) {
                    widget.budgetToAdd(
                      double.parse(budgetController.text),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO implement way to choose timeframe(month?)
//TODO investigate how app knows date & forces user to set new budget if new month has started