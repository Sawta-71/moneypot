import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class NumberInput {
  final String id;
  final String number;
  final bool setIcon;
  final IconData icon;


   const NumberInput({
    @required this.id,
    @required this.number,
    @required this.setIcon,
    @required this.icon,
  });
}
