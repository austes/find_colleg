import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Aukstas'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text('Pasirinkti auksta'),
              new RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: new Text('Sugrizti'),
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
                  })
            ],
          ),
        ),
      ),
    );
  }
}
