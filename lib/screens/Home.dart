import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Programele rasti kolega'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text('Sveiki atvykę!',
                  style: new TextStyle(
                      fontSize: 35.0, fontWeight: FontWeight.bold)),
              new Text('Programėlė darbuotojų vietai surasti',
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold)),
              new RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/SecondEdit');
                  },
                  color: Theme.of(context).accentColor,
                  elevation: 15.0,
                  padding: const EdgeInsets.all(8.0),
                  splashColor: Theme.of(context).accentColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(35.0)),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        "Ieskoti pagal varda",
                        style: new TextStyle(
                          color: new Color(0xFFFFFFFF),
                        ),
                      ),
                      new Icon(Icons.arrow_forward_ios,
                          color: new Color(0xFFFFFFFF))
                    ],
                  )),
              new RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Third');
                  },
                  padding: const EdgeInsets.all(8.0),
                  color: Theme.of(context).accentColor,
                  elevation: 15.0,
                  splashColor: Theme.of(context).accentColor,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(35.0)),
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        "Ieskoti pagal vieta",
                        style: new TextStyle(
                          color: new Color(0xFFFFFFFF),
                        ),
                      ),
                      new Icon(Icons.arrow_forward_ios,
                          color: new Color(0xFFFFFFFF))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
