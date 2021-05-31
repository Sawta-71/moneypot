import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneypot/provider/data.dart';
import 'package:moneypot/screen/error_screens/comming_soon.dart';
import 'package:moneypot/widget/bids.dart';
import 'package:moneypot/widget/one_day_bids.dart';
import 'package:moneypot/widget/five_min_games.dart';
import 'package:ntp/ntp.dart';

class GameTabs extends StatefulWidget {
  @override
  _GameTabsState createState() => _GameTabsState();
}

class _GameTabsState extends State<GameTabs> {
  String _netDate;
  getNetworkTime() async {
    var now = await NTP.now();

    setState(() {
      _netDate = (DateFormat.yMMMMd().format(now)).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getNetworkTime();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0),
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          componies[index].type,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                        Text(
                          _netDate.toString(),
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      componies[index].componyName != 'JANTA RAJ'
                          ? Container(
                              height: 25,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40.0),
                                    bottomRight: Radius.circular(40.0)),
                              ),
                              child: Text(
                                componies[index].openTime,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            )
                          : SizedBox(),
                      Text(
                        componies[index].componyName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      componies[index].componyName != 'JANTA RAJ'
                          ? Container(
                              height: 25,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40.0),
                                    bottomLeft: Radius.circular(40.0)),
                              ),
                              child: Text(
                                componies[index].closeTime,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0)),
                      color: Colors.grey[100],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            componies[index].componyName == 'JANTA RAJ'
                                ? 'Rate:1×10=10 total ten digit'
                                : '',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 20,
                            width: 61,
                            child: OutlineButton(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Play',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12),
                              ),
                              onPressed: () {
                                if (componies[index].componyName ==
                                    'JANTA RAJ') {
                                  Navigator.of(context)
                                      .pushNamed(FiveMinGames.routeName);
                                } else {
                                  // Navigator.of(context)
                                  //     .pushNamed(CommingSoon.routeName);
//                                      Navigator.push(
//                                                       context,
//                                                       MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             Bids(routeData: <
//                                                                 String,
//                                                                 dynamic>{
//                                                           'index':
//                                                              {"d_5_m_id": 14385, "s_time": "10:40 pm", "c_s_time": "22:40:00", "is_winner_set": 0, "end_time": "10:45 pm",
// "c_end_time": "22:45:00", "win_no": null, "game_date": "2021-04-20", "inserted_date": "2021-04-20 00:00:02", "game_date_time": "2021-04-20 22:45:00",
// "test": "1618938900", "win_time": "2021-04-19 18:30:02", "is_result_set": 0, "set_win_no": null},
//                                                           'type': 'allGame'
//                                                         }),
//                                                       ),
//                                                     );
// 

 Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OneDayBids(routeData: {
                                                          'index':
                                                             {"componie_name":componies[index].componyName, "d_5_m_id": componies[index].id, "s_time": componies[index].openTime, "c_s_time": "22:40:00", "is_winner_set": 0, "end_time": componies[index].closeTime,
"c_end_time": "22:45:00", "win_no": null, "game_date": componies[index].date, "inserted_date": "2021-04-20 00:00:02", "game_date_time": "2021-04-20 22:45:00",
"test": "1618938900", "win_time": "2021-04-19 18:30:02", "is_result_set": 0, "set_win_no": null},
                                                          'type': 'allGame'
                                                        }),
                                                      ),
                                                    );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: componies.length,
    );
  }
}
