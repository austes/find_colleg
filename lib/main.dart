//import 'package:find_colleague/screens/SecondEdit.dart';
import 'package:flutter/material.dart';
import 'package:find_colleague/screens/Home.dart';
import 'package:find_colleague/screens/Second.dart';
import 'package:find_colleague/screens/Third.dart';
import 'package:find_colleague/screens/FourthTen.dart';
import 'package:find_colleague/screens/FourthEleven.dart';




void main() {
  runApp(new MyApp());
 //loadDarbuotojai();
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Navigation',
      routes: <String,WidgetBuilder>{
        '/Home': (BuildContext context) => new Home(),
        '/Second': (BuildContext context) => new Second(),
        '/Third': (BuildContext context) => new Third(),
        '/FourthTen': (BuildContext context) => new FourthTen(),
        '/FourthEleven': (BuildContext context) => new FourthEleven(),
        
      },
      home: new Home(),
    );
  }

}
