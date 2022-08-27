import 'package:budgettrackerapp/models/transaction_item_model.dart';
import 'package:budgettrackerapp/services/local_storage_service.dart';
import 'package:flutter/material.dart';

class BudgetViewModel extends ChangeNotifier {
  double getBudget() => LocalStorageService().getBudget();
  double getBalance() => LocalStorageService().getBalance();

  List<TransactionItemModel> get items =>
      LocalStorageService().getAllTransactions();

  set budget(double value) {
    LocalStorageService().saveBudget(value);
    notifyListeners();
  }

  void addItem(TransactionItemModel item) {
    LocalStorageService().saveTransactionItem(item);
    notifyListeners();
  }

  void deleteItem(TransactionItemModel item) {
    final localStorage = LocalStorageService();
    localStorage.deleteTransactionItem(item);
    notifyListeners();
  }
}
