import 'package:flutter/material.dart';

class FamilyPanna extends StatefulWidget {
  final String type;
  final List<String> data;
  FamilyPanna(this.type,this.data);
  @override
  _FamilyPannaState createState() => _FamilyPannaState();
}

class _FamilyPannaState extends State<FamilyPanna> {
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
                      children: List.generate(widget.data.length, (index) {
                        return RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            widget.data[index],
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
_returnData(widget.data[index],widget.type);
                          },
                        );
                      }),),),
    );
  }
}