import 'package:flutter/material.dart';
import '../../widget/my_bids.dart';

class BidsScreen extends StatefulWidget {
  static const routeName = '/my-bids';

  @override
  _BidsScreenState createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  @override
  Widget build(BuildContext context) {
    // NetworkStatus networkStatus = Provider.of<NetworkStatus>(context);
    // return networkStatus==NetworkStatus.Online? MyBids():NoInternetConnection();

    return MyBids();
  }
}
