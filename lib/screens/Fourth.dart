import 'package:flutter/material.dart';

class Fourth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Sektorius'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text('Pasirinkti setoriu'),
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
