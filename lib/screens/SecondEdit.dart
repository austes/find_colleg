import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async' show Future;


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//TODO Reikia ideti SearchBar
//TODO Reikia atvaizduoti laukus kortelemis (CardView)
//TODO Reikia ideti filtra pagal komanda (on select dropdown update listview)

Future<List<ColleagueTemp>> fetchPhotos(http.Client client) async {
  String response = await loadColleaguesList();

  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseColleagues, response);
}

// A function that will convert a response body into a List<Photo>
List<ColleagueTemp> parseColleagues(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ColleagueTemp>((json) => ColleagueTemp.fromJson(json)).toList();
}

Future<String> loadColleaguesList() async {
  return await rootBundle.loadString('assets/data.json');
}

class ColleagueTemp{
  final String name;
  final String surname;
  final String team;
  final String respons;
  
  ColleagueTemp({
    this.name,
    this.surname,
    this.team,
    this.respons
  });

  factory ColleagueTemp.fromJson(Map<String, dynamic> parsedJson){
    return ColleagueTemp(
      name: parsedJson['name'] as String,
      surname : parsedJson['surname'] as String,
      team : parsedJson ['team'] as String,
      respons : parsedJson ['respons'] as String,
    );
  }
}

class SecondEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<ColleagueTemp>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ColleagueList(collegues: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ColleagueList extends StatelessWidget {
  final List<ColleagueTemp> collegues;

  ColleagueList({Key key, this.collegues}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: collegues.length,
      itemBuilder: (context, index) {
        return new ListTile(
          title: new Text(collegues[index].name),
        );
      },
    );
  }
}