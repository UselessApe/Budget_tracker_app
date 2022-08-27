import 'package:budgettrackerapp/models/transaction_item_model.dart';
import 'package:budgettrackerapp/services/budget_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final TransactionItemModel item;

  const TransactionCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Text("Delete item"),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          final budgetViewModel = Provider.of<BudgetViewModel>(
                              context,
                              listen: false);
                          budgetViewModel.deleteItem(item);
                          Navigator.pop(context);
                        },
                        child: const Text("Yes")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"))
                  ],
                ),
              ),
            );
          })),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(3, 0),
                  blurRadius: 6,
                ),
              ],
            ),
            padding: const EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  item.itemTitle,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Text(
                  (!item.isExpense ? "+ " : "- ") +
                      item.transactionAmount.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
