import 'package:flutter/foundation.dart';

class Game {
   String type;
   String numbers;
 String amount;
 int isWinner;

  Game({
    @required this.type,
    @required this.numbers,
    @required this.amount,
    this.isWinner
  });
}
