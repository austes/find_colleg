import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async' show Future;
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// //TODO Reikia ideti SearchBar
// //TODO Reikia atvaizduoti laukus kortelemis (CardView)
// //TODO Reikia ideti filtra pagal komanda (on select dropdown update listview)


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

// class Second extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: FutureBuilder<List<ColleagueTemp>>(
//         future: fetchPhotos(http.Client()),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) print(snapshot.error);

//           return snapshot.hasData
//               ? ColleagueList(collegues: snapshot.data)
//               : Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

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


void main() => runApp(new Second());

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Api Filter list Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ExamplePage(),
 
     
     );
  }

}

class ExamplePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
 
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search Example' );

  _ExamplePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState() {
    this.loadColleaguesList();
    super.initState();
  }

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
      appBar: _buildBar(context),
    
      children: <Widget>[_buildList()],
      
      resizeToAvoidBottomPadding: false,
    );
    

     
    
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name'].toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'Search Example' );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

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


  // void _getNames() async {
  //   final response = await dio.get('https://swapi.co/api/people');
  //   List tempList = new List();
  //   for (int i = 0; i < response.data['results'].length; i++) {
  //     tempList.add(response.data['results'][i]);
  //   }
  //   setState(() {
  //     names =ColleagueTemp;
  //     names.shuffle();
  //     filteredNames = names;
  //   });
  // }
}
}