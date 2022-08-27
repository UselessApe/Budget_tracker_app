import 'package:budgettrackerapp/models/transaction_item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String transactionsBoxKey = "transactionsBox";
  static const String balanceBoxKey = "balanceBox";
  static const String budgetBoxKey = "budgetBoxKey";

  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }
  LocalStorageService._internal();

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionItemModelAdapter());
    }

    await Hive.openBox<double>(budgetBoxKey);
    await Hive.openBox<TransactionItemModel>(transactionsBoxKey);
    await Hive.openBox<double>(balanceBoxKey);
  }

  void saveTransactionItem(TransactionItemModel transaction) {
    Hive.box<TransactionItemModel>(transactionsBoxKey).add(transaction);
    saveBalance(transaction);
  }

  void deleteTransactionItem(TransactionItemModel transaction) {
    final transactions = Hive.box<TransactionItemModel>(transactionsBoxKey);

    final Map<dynamic, TransactionItemModel> map = transactions.toMap();
    dynamic desiredKey;
    map.forEach((key, value) {
      if (value.itemTitle == transaction.itemTitle) desiredKey = key;
    });
    transactions.delete(desiredKey);
    saveBalanceOnDelete(transaction);
  }

  List<TransactionItemModel> getAllTransactions() {
    return Hive.box<TransactionItemModel>(transactionsBoxKey).values.toList();
  }

  double getBalance() {
    return Hive.box<double>(balanceBoxKey).get("balance") ?? 0;
  }

  Future<void> saveBudget(double budget) {
    return Hive.box<double>(budgetBoxKey).put("budget", budget);
  }

  double getBudget() {
    return Hive.box<double>(budgetBoxKey).get("budget") ?? 0;
  }

  Future<void> saveBalance(TransactionItemModel item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance + item.transactionAmount);
    } else {
      balanceBox.put("balance", currentBalance - item.transactionAmount);
    }
  }

  Future<void> saveBalanceOnDelete(TransactionItemModel item) async {
    final balanceBox = Hive.box<double>(balanceBoxKey);
    final currentBalance = balanceBox.get("balance") ?? 0;
    if (item.isExpense) {
      balanceBox.put("balance", currentBalance - item.transactionAmount);
    } else {
      balanceBox.put("balance", currentBalance + item.transactionAmount);
    }
  }
}
