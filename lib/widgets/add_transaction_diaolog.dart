import 'package:budgettrackerapp/models/transaction_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransactionDiaolog extends StatefulWidget {
  final Function(TransactionItemModel) itemToAdd;

  const AddTransactionDiaolog({required this.itemToAdd, Key? key})
      : super(key: key);

  @override
  State<AddTransactionDiaolog> createState() => _AddTransactionDiaologState();
}

class _AddTransactionDiaologState extends State<AddTransactionDiaolog> {
  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  bool _isExpenseController = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                " Add an expense",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: itemTitleController,
                decoration:
                    const InputDecoration(hintText: "Name of transaction"),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: "Amount in \$"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Is expense?"),
                  Switch.adaptive(
                    value: _isExpenseController,
                    onChanged: (b) {
                      setState(
                        () {
                          _isExpenseController = b;
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.isNotEmpty &&
                      itemTitleController.text.isNotEmpty) {
                    widget.itemToAdd(
                      TransactionItemModel(
                          itemTitle: itemTitleController.text,
                          transactionAmount:
                              double.parse(amountController.text),
                          isExpense: _isExpenseController),
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
