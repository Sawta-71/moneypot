import 'package:flutter/foundation.dart';

class Flag with ChangeNotifier{
  String _flag='hi';

  String get bidFlag{
    return _flag;
  }

  void setFlag(String flag){
    _flag=flag;
    notifyListeners();
  }
}