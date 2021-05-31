import 'package:flutter/foundation.dart';

class User{
 String name;
 String email;
 String mobileNo;
 String walletAmount;

 set userName(String name) {
    name = name;
  }

set userEmail(String email) {
    email = email;
  }

 set userMobileNo(String mobileNo) {
    mobileNo = mobileNo;
  }

 set userWalletAmount(String walletAmount) {
    walletAmount = walletAmount;
  }

    Map<String,dynamic> get userData {
    return {
      "name": name,
      "email": email,
      "mobileNo":mobileNo,
      "walletAmount": walletAmount,
    };
  }

User({ @required this.name, @required this.email, @required this.mobileNo, @required this.walletAmount,});


}