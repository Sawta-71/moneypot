import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AmountInput {
  final String id;
  final String number;
  final bool setText;
  final String text;

  const AmountInput({
    @required this.id,
    @required this.number,
    @required this.setText,
    @required this.text,
  });
}
