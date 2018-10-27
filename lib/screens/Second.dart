import 'package:flutter/material.dart';
import 'dart:convert';
//import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Second());

class Second extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatalogPage(),
    );
  }
}

/// The screen which displays the full catalog of people
class CatalogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Darbuotojų sąrašas'),
      ),
      body: Center(
        child: CatalogList(),
      ),
    );
  }
}

/// The list of people and its search bar.
class CatalogList extends StatefulWidget {
  @override
  _CatalogListState createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  /// All people in the catalog.
  List<Book> books;

  /// People currently being displayed in the list.
  List<Book> displayedBooks;

  /// The controller to keep track of search field content and changes.
  final TextEditingController searchController = TextEditingController();

  /// Kicks off API fetch on creation.
  _CatalogListState() {
    _fetchBookList();
    searchController.addListener(_search);
  }

  /// Fetches the list of people and updates state.
  void _fetchBookList() async {
    var uri = new Uri.http('find-colleague.000webhostapp.com', '/all');
    // debugPrint('response: $response');
    http.Response response = await http.get(uri);
    List<Map<String, dynamic>> newBooksRaw =
        json.decode(response.body).cast<Map<String, dynamic>>();
    List<Book> newBooks =
        newBooksRaw.map((bookData) => Book.fromJson(bookData)).toList();
    setState(() {
      books = newBooks;
      displayedBooks = books;
    });
  }

  /// Performs a case insensitive search.
  void _search() {
    if (searchController.text == '') {
      setState(() {
        displayedBooks = books;
      });
    } else {
      List<Book> filteredBooks = books
          .where((book) => book.name
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      setState(() {
        displayedBooks = filteredBooks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return displayedBooks != null
        ? Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'Įrašykite vardą...'),
                  controller: searchController,
                ),
              ),
              new Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) => Card(
                          elevation: 2.0,
                          child: ListTile(
                              title: Text(
                                displayedBooks[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(displayedBooks[index].surname),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return DetailPage(
                                      "${displayedBooks[index].id}");
                                }));
                              }),
                        ),
                    itemCount: displayedBooks.length,
                  ),
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}

class Book {
  final String id;
  final String name;
  final String surname;
  final String team;
  final String respons;

  /// Creates a person instance out of JSON received from the API.
  Book.fromJson(Map<String, dynamic> json)
      : id = "${json['id']}",
        name = json['name'],
        surname = json['surname'],
        team = json['team'],
        respons = json['respons'];
}

/// The screen which displays the full details of a given person.
class DetailPage extends StatefulWidget {
  final String bookId;

  DetailPage(this.bookId);

  @override
  _DetailPageState createState() => _DetailPageState(this.bookId);
}

class _DetailPageState extends State<DetailPage> {
  /// The full people data.
  Book book;

  /// Flag indicating whether the name field is nonempty.
  bool fieldHasContent = false;

  /// The controller to keep track of name field content and changes.
  final TextEditingController nameController = TextEditingController();

  String bookID;

  /// Kicks off API fetch on creation.
  _DetailPageState(String bookId) {
    this.bookID = bookId;
    _fetchBookDetails();
    nameController.addListener(_handleTextChange);
  }

  /// Fetches the person details and updates state.
  void _fetchBookDetails() async {
    var uri =
        new Uri.https('find-colleague.000webhostapp.com', '/find?id=$bookID');
    var decoded = Uri.decodeFull(uri.toString());
    debugPrint('movieTitle: $decoded');
    http.Response response = await http.get(decoded);
    debugPrint('response: $response');
    List<dynamic> newBookRaw = json.decode(response.body);

    Book newBook = Book.fromJson(newBookRaw[0]);
    setState(() {
      book = newBook;
    });
  }

  /// Check out a person to the name entered.
  // void _checkOut() async {
  //   http.Response response = await http.post(
  //     'http://<API location>/checkOutBook',
  //     body: {'id': book.id, 'name': nameController.text},
  //   );
  //   Map<String, dynamic> newBookRaw = json.decode(response.body);
  //   Book newBook = Book.fromJson(newBookRaw);
  //   setState(() {
  //     book = newBook;
  //   });
  // }

  /// Remove a checked out entry for the name entered.
  // void _return() async {
  //   http.Response response = await http.post(
  //     'http://<API location>/returnBook',
  //     body: {'id': book.id, 'name': nameController.text},
  //   );
  //   Map<String, dynamic> newBookRaw = json.decode(response.body);
  //   Book newBook = Book.fromJson(newBookRaw);
  //   setState(() {
  //     book = newBook;
  //   });
  // }

  void _handleTextChange() {
    setState(() {
      fieldHasContent = nameController.text != '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.name ?? ''),
      ),
      body: book != null
          ? new Center(
              child: new SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 5.0,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _BodySection('Vardas:', book.name),
                          _BodySection('Pavardė:', book.surname),
                          _BodySection('Komanda:', book.team ?? 'N/A'),
                          //_BodySection('Kazkas dar', book.respons),
                          // Column(
                          //   children: <Widget>[
                          //     new Padding(
                          //       padding: const EdgeInsets.only(top: 16.0),
                          //       child: new Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceEvenly,
                          //         children: <Widget>[
                                    
                          //         ],
                          //       ),
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    )),
                  ),
                  
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()));
        
  }
}

class _BodySection extends StatelessWidget {
  final String title;
  final String content;

  _BodySection(this.title, this.content);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.title),
          Text(content, style: TextStyle(color: Colors.grey[700]))
          
        ],
      ),
    );
  }
}
