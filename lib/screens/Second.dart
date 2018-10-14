import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async' show Future;


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


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

void main() => runApp(new MaterialApp(
      home: new Second()
    
    ));

class Second extends StatefulWidget {
  @override
  _SecondState createState() => new _SecondState();
}

@override
  void initState() {
    loadColleaguesList();
    ColleagueList();
  }
  
class _SecondState extends State<Second> {
  Widget appBarTitle = new Text(
    "Irašykite vardą...",
    style: new TextStyle(color: Colors.white),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List<dynamic> _list;
  bool _isSearching;
  List data;
  String _searchText = " ";
  List searchresult = new List();

  _SecondState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = " ";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }
@override
  void initState() {
    super.initState();
    _isSearching = false;

    loadColleaguesList();
    ColleagueList();
  }

  List<String> _teams = <String>[
    '',
    'pirmoji',
    'antroji',
    'trečioji',
    'ketvirtoji',
    'penktoji'
  ];
  String _team = '';


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      appBar: buildAppBar(context),
      body: new Container(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
            new Flexible(
              child: searchresult.length != 0 || _controller.text.isNotEmpty
                  ? new ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchresult.length,
                      itemBuilder: (BuildContext context, int index) {
                        String listData = searchresult[index];
                        return new ListTile(
                          title: new Text(listData.toString()),
                        );
                      },
                    )
                  : new ListView.builder(
                      shrinkWrap: true,
                     // itemCount: _list.length,
                      itemBuilder: (BuildContext context, int index) {
                        String listData = _list[index];
                        return new ListTile(
                          title: new Text(listData.toString()),
                        );
                      },
                    ),
            ),
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Spauskite norėdami pamatyti komandų sąrašą',
              ),
              isEmpty: _team == '',
              child: new DropdownButtonHideUnderline(
                child: new DropdownButton<String>(
                  value: _team,
                  isDense: true,
                  onChanged: (String newValue) {
                    setState(() {
                      _team = newValue;
                    });
                  },
                  items: _teams.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ])),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
      new IconButton(
        icon: icon,
        onPressed: () {
          setState(() {
            if (this.icon.icon == Icons.search) {
              this.icon = new Icon(
                Icons.close,
                color: Colors.white,
              );
              this.appBarTitle = new TextField(
                controller: _controller,
                style: new TextStyle(
                  color: Colors.white,
                ),
                decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search, color: Colors.white),
                    hintText: "vardo vieta...",
                    hintStyle: new TextStyle(color: Colors.white)),
                onChanged: searchOperation,
              );
              _handleSearchStart();
            } else {
              _handleSearchEnd();
            }
          });
        },
      ),
    ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "Search Sample",
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(data);
        }
      }
    }
  }
}

