import 'package:flutter/material.dart';
import 'package:moneypot/provider/data.dart';

class AllPanna extends StatefulWidget {
  final String type;
  AllPanna(this.type);
  @override
  _AllPannaState createState() => _AllPannaState();
}

class _AllPannaState extends State<AllPanna> {
  List<String> data;
  void _returnData(number, pattiType) {
    final Map<String, dynamic> data = {
      "number": number,
      "type": widget.type,
      "patti_type": pattiType
    };

    Navigator.pop(
      context,
      data,
    );
  }

  getData() {
    setState(() {
      data = [];
    });
    if (widget.type == 'ARB Cut Panna') {
      data = ABR_CUT_PANNA;
    }
    if (widget.type == 'Running Panna') {
      data = RUNNING_PANNA;
    }

    if (widget.type == 'Aki Beki Running Panna') {
      data = AKI_BEKI_RUNING_PANNA;
    }
    if (widget.type == 'Aki Running Panna') {
      data = AKI_RUNING_PANNA;
    }
    if (widget.type == 'Beki Running Panna') {
      data = BEKI_RUNING_PANNA;
    }
    if (widget.type == 'Aki Beki Panna') {
      data = AKI_BEKI_PANNA;
    }
    if (widget.type == 'Aki Panna') {
      data = AKI_PANNA;
    }
    if (widget.type == 'Beki Panna') {
      data = BEKI_PANNA;
    }
    if(widget.type=='CP'){
      for(int i=0;i<CP_PATTI.length;i++){
        data.add(CP_PATTI[i].number);
      }
     
    }

    print('type');
    print(widget.type);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.type=='CP'?'Choose One CP':widget.type),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: widget.type=='CP'?4:3,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 2.5,
          children: List.generate(data.length, (index) {
            return RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                data[index],
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              padding: EdgeInsets.all(8.0),
              onPressed: () {
                _returnData(data[index], widget.type);
              },
            );
          }),
        ),
      ),
    );
  }
}
