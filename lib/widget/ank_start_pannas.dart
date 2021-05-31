import 'package:flutter/material.dart';

class AnkStartPanna extends StatefulWidget {
    final String type;
  final List<String> pannas;


  AnkStartPanna(this.type,this.pannas,);
  @override
  _AnkStartPannaState createState() => _AnkStartPannaState();
}

class _AnkStartPannaState extends State<AnkStartPanna> {

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        title: Text('Choose One Panna'),
      ),

      body: Container(
                  height: MediaQuery.of(context).size.height * 0.82,
                  padding: EdgeInsets.all(10),
                  child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 2.5,
                      children: List.generate(widget.pannas.length, (index) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            widget.pannas[index],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
_returnData(widget.pannas[index],widget.type);
                          },
                        );
                      }),),),
    );
  }
  }
