import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneypot/models/wallet_amount.dart';
import 'package:moneypot/screen/error_screens/comming_soon.dart';
import 'package:moneypot/screen/error_screens/time_date_check.dart';
import 'package:moneypot/screen/onboarding_screen/onboarding_screen.dart';
import 'package:moneypot/widget/five_min_games.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './provider/flag.dart';
import './widget/play_number.dart';
import './widget/wallet.dart';
import './screen/tab_screens/bids_screen.dart';
import './screen/tab_screens/profile_screen.dart';
import 'screen/tab_screens/result_screen.dart';
import './screen/tab_screens/home_screen.dart';
import './screen/tab_screens/tab_screen.dart';
import './screen/log_screens/login_screen.dart';
import './screen/log_screens/change_password_screen.dart';
import './screen/error_screens/time_date_check.dart';
import './widget/bids.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool _onBoarding = false;

  Future<void> loginScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool onBoarding = prefs.getBool('onboarding') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
      _onBoarding = onBoarding;
    });
  }

  @override
  void initState() {
    super.initState();
    loginScreen();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Flag()),
        ChangeNotifierProvider(create: (context)=>WalletAmount(),)
      ],
      child: MaterialApp(
        title: 'Money Pot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.white,
          primaryColorLight: Colors.pink[100],
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              )),
        ),
        home: (_onBoarding && _isLoggedIn)
            ? TabScreen(selectedIndex: 0)
            : (_onBoarding && !_isLoggedIn)
                ? LoginScreen()
                : OnBoarding_Screen(),

        routes: {
          OnBoarding_Screen.routeName: (ctx) => OnBoarding_Screen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          BidsScreen.routeName: (ctx) => BidsScreen(),
          ResultScreen.routeName: (ctx) => ResultScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
          TabScreen.routeName: (ctx) => TabScreen(selectedIndex: 0),
          Bids.routeName: (ctx) => Bids(),
          Wallet.routeName: (ctx) => Wallet(),
          PlayNumber.routeName: (ctx) => PlayNumber(),
          CommingSoon.routeName:(ctx)=>CommingSoon(),
          FiveMinGames.routeName:(ctx)=>FiveMinGames(),
          TimeDateCheck.routeName:(ctx)=>TimeDateCheck(),
        },
      ),
    );
  }
}

