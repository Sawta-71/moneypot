import 'package:flutter/foundation.dart';

class Componies {
  final String id;
  final String componyName;
  final String openTime;
  final String closeTime;
  final String date;
  final String open;
  final String close;
  final String openPatti;
  final String closePatti;
  final String bidCount;
  final bool isPlay;
  final String type;

  Componies({
    @required this.id,
    @required this.componyName,
    @required this.openTime,
    @required this.closeTime,
    @required this.date,
    @required this.open,
    @required this.close,
    @required this.openPatti,
    @required this.closePatti,
    @required this.bidCount,
    @required this.isPlay,
    @required this.type,
  });

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'componyName': componyName,
      'openTime': openTime,
      'closeTime': closeTime,
      'date': date,
      'open': open,
      'close': close,
      'openPatti': openPatti,
      'closePatti': closePatti,
      'bidCount': bidCount,
      'isPlay': isPlay,
      'type': type,
    };
  }
}
