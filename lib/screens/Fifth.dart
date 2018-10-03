import 'package:flutter/material.dart';

class Fifth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Vieta'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text('Jusu pasirinkimas'),
              new RaisedButton(
                  child: new Text('Sugrizti'),
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/Home', (Route<dynamic> route) => false);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
