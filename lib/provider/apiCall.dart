import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final String baseAPI ='https://peoplexch9.com/public/';

postData(url, data, tokenReq) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String finalUrl = baseAPI + url;

  var postData;
  if (tokenReq) {
    postData = jsonDecode(data);
    postData['token'] = prefs.getString('token') ?? '';
    postData=jsonEncode(postData);
    print(postData);
  }else{
    postData=data;
  }

  return await http.post(
    finalUrl,
    headers: <String, String>{
      'Content-Type':'application/json',
      'APPKEY':'money_pot_app_123'
    },
    body: postData,
  );
}
