import 'dart:async';
import 'dart:convert';

import 'package:find_colleague/Colleague.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Second extends StatefulWidget {
  @override
  SecondState createState() => new SecondState();
}

class SecondState extends State<Second> {
  List data;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Listviews"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Text(data[index]["name"]),
          );
        },
      ),
    );
  }


 Future<String> _loadColleagueAsset() async {
  return await rootBundle.loadString('assets/colleague.json');
}


Future loadColleague() async {
  String jsonString = await _loadColleagueAsset();
  final jsonResponse = json.decode(jsonString);
  Colleague colleague = new Colleague.fromJson(jsonResponse);
  print(colleague.name);
}

  @override
  void initState() {
    super.initState();
    this.loadColleague();
  }
}
