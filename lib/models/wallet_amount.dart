import 'package:flutter/widgets.dart';

class WalletAmount extends ChangeNotifier{
  String _amount;
  String get amount=>_amount;

  WalletAmount();

  void changeAmount(String val){
    _amount=val;
    notifyListeners();
  }
}