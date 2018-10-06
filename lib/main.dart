import 'package:find_colleague/screens/SecondEdit.dart';
import 'package:flutter/material.dart';
import 'package:find_colleague/screens/Home.dart';
import 'package:find_colleague/screens/Second.dart';
import 'package:find_colleague/screens/Third.dart';
import 'package:find_colleague/screens/Fourth.dart';
import 'package:find_colleague/screens/Fifth.dart';


void main() {
  runApp(new MyApp());
 //loadDarbuotojai();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigation',
      routes: <String,WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(),
        '/SecondEdit': (BuildContext context) => new SecondEdit(),
        '/Third': (BuildContext context) => new Third(),
        '/Fourth': (BuildContext context) => new Fourth(),
        '/Fifth': (BuildContext context) => new Fifth(),
      },
      home: new Home(),
    );
  }

}