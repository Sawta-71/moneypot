import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:moneypot/models/wallet_amount.dart';
import 'package:moneypot/provider/apiCall.dart';
import 'package:moneypot/screen/error_screens/autoLogOut.dart';
import 'package:moneypot/screen/log_screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home_screen.dart';
import './bids_screen.dart';
import './profile_screen.dart';
import 'result_screen.dart';
import '../../widget/wallet.dart';

class TabScreen extends StatefulWidget {
  final int selectedIndex;
  TabScreen({
    Key key,
    this.selectedIndex,
  }) : super(key: key);
  static const routeName = '/tabs';

  @override
  _TabScreenState createState() => _TabScreenState(
        selectedIndex: this.selectedIndex,
      );
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': HomeScreen(), 'title': 'Games'},
    {'page': BidsScreen(), 'title': 'Bets'},
    {'page': ResultScreen(), 'title': 'Results'},
    {'page': ProfileScreen(), 'title': 'Profile'},
  ];

  String name = '', email = '', mNo = '';

  int selectedIndex;
  List bid = [];
  _TabScreenState({
    this.selectedIndex,
  });

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      selectedIndex = null;
    });
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Hello';
      email = prefs.getString('email') ?? '';
      mNo = prefs.getString('mobileNo') ?? '';
    });
  }

  _getWalletAmount() async {
    final String url = 'api/get_user_wallet_amount';
    final data = jsonEncode({});

    try {
      var response = await postData(url, data, true);

      if (response.statusCode == 200) {
        final wData = jsonDecode(response.body);

        Provider.of<WalletAmount>(context, listen: false)
            .changeAmount(wData['wallet_amount']);
      } else if (response.statusCode == 408) {
        AutoLogOut().popUpFor408(context);
      } else {
        final eData = jsonDecode(response.body);
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    _getWalletAmount();
  }

  @override
  Widget build(BuildContext context) {
    final walletAmount = Provider.of<WalletAmount>(context);
    selectedIndex == 1
        ? _selectedPageIndex = selectedIndex
        : _selectedPageIndex = _selectedPageIndex;

    final appBar = AppBar(
      title: Text(_pages[_selectedPageIndex]['title']),
      actions: [
        Row(
          children: [
            Text(walletAmount.amount ?? '',
                style: TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
              ),
              onPressed: () {
                _getWalletAmount();
                Navigator.of(context).pushNamed(Wallet.routeName);
              },
            )
          ],
        ),
      ],
    );

    final profileAppBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      bottom: PreferredSize(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.account_box,
              color: Theme.of(context).accentColor,
              size: 120,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      mNo,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      email,
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setString('token', '');
                    await prefs.setString('name', '');
                    await prefs.setString('email', '');
                    await prefs.setString('mobileNo', '');
                    await prefs.setString('walletAmount', '');
                    await prefs.setBool('isLoggedIn', false);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        LoginScreen.routeName, (route) => false);
                  },
                )
              ],
            ),
          ],
        ),
        preferredSize: Size.fromHeight(64.0),
      ),
    );
    return Scaffold(
      appBar: _selectedPageIndex == 3 ? profileAppBar : appBar,
      body: Container(
        height:
            MediaQuery.of(context).size.height - appBar.preferredSize.height,
        child: _pages[_selectedPageIndex]['page'],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: widget.selectedIndex == 1
            ? _selectedPageIndex = 1
            : _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.home),
            label: 'Games',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.games),
            label: 'Bets',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.flag),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
