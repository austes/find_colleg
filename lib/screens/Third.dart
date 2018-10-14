import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/ten.png');
}

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pasirinkite aukštą:',
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      ),
      body: new Container(
        margin: new EdgeInsets.all(0.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              new Image.asset(
                'assets/ten.png',
                width: 450.0,
                height: 150.0,
              ),
              new Text('10',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              new Image.asset(
                'assets/eleven.png',
                width: 450.0,
                height: 150.0,
              ),
              new Text('11',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: new Text('Sugrįžti'),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/Home', (Route<dynamic> route) => false);
                      }),
                  new RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: new Text('Toliau'),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/Fourth', (Route<dynamic> route) => false);
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
