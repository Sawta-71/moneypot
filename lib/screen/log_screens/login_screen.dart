import 'dart:convert';
import 'package:moneypot/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../models/login.dart';
import './change_password_screen.dart';
import '../tab_screens/tab_screen.dart';
import '../../provider/apiCall.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _saveLogForm = Login(mobileNumber: null, password: '');
  bool _isHidden = true;
  bool _isLoginButtonVisible = true;
  User userData;
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();

    setState(() {
      _isLoginButtonVisible = false;
    });

    final String url = 'api/user_login';
    final data = jsonEncode(<String, dynamic>{
      'mobile_number': _saveLogForm.mobileNumber,
      'password': _saveLogForm.password,
    });

    final response = await postData(url, data, false);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('name', data['user_data']['user_name']);
      await prefs.setString('email', data['user_data']['user_email']);
      await prefs.setString('mobileNo', data['user_data']['mobile_number']);
      await prefs.setString('walletAmount', data['user_data']['wallet_amount']);
      await prefs.setBool('isLoggedIn', true);

      setState(() {
        _isLoginButtonVisible = true;
      });

      Navigator.of(context)
          .pushNamedAndRemoveUntil(TabScreen.routeName, (route) => false);
    } else {
      setState(() {
        _isLoginButtonVisible = true;
      });
      final snackBar = SnackBar(
        content: Row(
          children: [
            Icon(Icons.thumb_down),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Text(
                'Mobile Number or Password wrong',
              ),
            ),
          ],
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(
              right: 40,
              left: 40,
              top: 100,
            ),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/newLogo.jpg',
                          width: 250,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          '',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 24.00,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Hi there! Nice to see you again!',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mobile No',
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide mobile no.';
                      }
                      if (value.length > 10 || value.length < 10) {
                        return 'Please enter valid mobile no.';
                      }

                      return null;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onChanged: (newValue) {
                      _saveLogForm = Login(
                        mobileNumber: int.parse(newValue),
                        password: _saveLogForm.password,
                      );
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        child: _isHidden
                            ? Icon(
                                Icons.remove_red_eye,
                                color: Colors.black38,
                              )
                            : Icon(Icons.remove_red_eye, color: Colors.pink),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    obscureText: _isHidden,
                    focusNode: _passwordFocusNode,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide password';
                      }
                      if (value.length < 4) {
                        return 'Please provide 4 digit password';
                      }

                      return null;
                    },
                    onChanged: (newValue) {
                      _saveLogForm = Login(
                        mobileNumber: _saveLogForm.mobileNumber,
                        password: newValue,
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: _isLoginButtonVisible ? _saveForm : null,
                            child: Text('Sign In',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 16)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ChangePasswordScreen.routeName);
                              },
                              child: Text(
                                'Forget Password?',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
