import 'package:hive/hive.dart';

part 'transaction_item_model.g.dart';

@HiveType(typeId: 1)
class TransactionItemModel {
  @HiveField(0)
  String itemTitle;
  @HiveField(1)
  double transactionAmount;
  @HiveField(2)
  bool isExpense;
  TransactionItemModel({
    required this.itemTitle,
    required this.transactionAmount,
    this.isExpense = true,
  });
}
