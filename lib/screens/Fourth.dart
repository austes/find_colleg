import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'package:flutter/services.dart';


Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/a.png');
}


class Fourth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pasirinkite sektoriu'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
               new Image.asset(
              'assets/a.png',
              width: 250.0,
              height: 80.0,
            ),  
           
               new Text('A',
           style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
             new Image.asset(
              'assets/b.png',
             width: 250.0,
              height: 80.0,
            ),   
           new Text('B',
           style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
            new Image.asset(
              'assets/c.png',
             width: 250.0,
              height: 80.0,
            ),   
           new Text('C',
           style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),

              new RaisedButton(
                  padding: const EdgeInsets.all(8.0),
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: new Text('Sugrizti'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Third', (Route<dynamic> route) => false);
                  }),
              new RaisedButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text('Toliau'),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Fifth', (Route<dynamic> route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
