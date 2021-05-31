import 'package:flutter/foundation.dart';

class Transaction {
  final String transacionId;
  final String transacioName;
  final String date;
  final String amount;
  final String previousAmount;
  final bool isAdd;
  final bool isCommission;

  Transaction({
    @required this.transacionId,
    @required this.transacioName,
    @required this.date,
    @required this.amount,
    @required this.previousAmount,
    @required this.isAdd,
    @required this.isCommission,
  });
}
