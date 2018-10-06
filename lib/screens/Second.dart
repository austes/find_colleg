import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:find_colleague/Colleague.dart';
import 'package:flutter/services.dart';
import 'dart:async' show Future;

void main() => runApp(new MaterialApp(
      home: new Second(),
    ));

class Second extends StatefulWidget {
  @override
  _SecondState createState() => new _SecondState();
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
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }


Future<String> _loadColleagueAsset() async {
  return await rootBundle.loadString('assets/data.json');
}


  @override
  void initState() {
    super.initState();
    _isSearching = false;
    values();
    this.loadColleague();
  }

  void values() {
    _list = List();
    _list.add("Gabija Cibauskaite");
    _list.add("Guste Abkaite");
    _list.add("Ieva Grigaityte");
    _list.add("Kotryna Badaugiene");
    _list.add("Mantas Danyla");
    _list.add("Motiejus Antonovas");
    _list.add("Giedrius Dolmatovas");
    _list.add("cia sarasas");
  }

Future loadColleague() async {
  String jsonString = await _loadColleagueAsset();
  final jsonResponse = json.decode(jsonString);
  Colleague colleague = new Colleague.fromJson(jsonResponse);
  print(colleague.name);
}


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
                          itemCount: _list.length,
                          itemBuilder: (BuildContext context, int index) {
                            String listData = _list[index];
                            return new ListTile(
                              title: new Text(listData.toString()),
                            );
                          },
                        ))
            ],
          ),
        ));
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







 



