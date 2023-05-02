import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_and_api/models/book_model.dart';

class LocalJson extends StatefulWidget {
  const LocalJson({Key? key}) : super(key: key);

  @override
  State<LocalJson> createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  late final Future<List<Book>> _allBooks;

  @override
  void initState() {
    _allBooks = readBooksJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    readBooksJson();
    return Scaffold(
      appBar: AppBar(title: const Text('Using Local Json')),
      body: FutureBuilder(
        future: _allBooks,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Book> bookList = snapshot.data!;
            return ListView.builder(
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                Book currentBook = bookList[index];
                return ListTile(
                  title: Text(currentBook.bookName),
                  subtitle: Text(currentBook.author),
                  leading: CircleAvatar(child: Text(currentBook.id.toString())),
                );
            });
          } else if (snapshot.hasError) {
            return const Center(child: Text('You don\'t have a list'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }

  Future<List<Book>> readBooksJson() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String readData = await DefaultAssetBundle.of(context)
          .loadString('assets/data/books.json');
      var jsonData = jsonDecode(readData);
      List<Book> allBooks = (jsonData as List)
          .map((currentBook) => Book.fromMap(currentBook))
          .toList();
      return allBooks;
    } catch (e) {
      debugPrint(e.toString());
      return Future.error(e.toString());
    }
  }
}
