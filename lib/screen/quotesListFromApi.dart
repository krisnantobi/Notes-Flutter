import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/models/QuoteModel.dart';

// Penambahan komponent ini untuk menampikan data dari API.
class QuoteListFromApi extends StatefulWidget {
  @override
  _QuoteListFromApiState createState() => _QuoteListFromApiState();
}

class _QuoteListFromApiState extends State<QuoteListFromApi> {
  _QuoteListFromApiState();

// Proses penarikan data dari api quoteable.com/random
  Future<QuoteModel> get_data() async {
    var url = Uri.parse('http://api.quotable.io/random');
    var res = await http.get(url);
    // Data json response di decode menjadi array
    final resJson = jsonDecode(res.body);

    // Data json array di lempar ke class QuoteModel untuk di normalize
    return QuoteModel.fromJson(resJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Pemberian nama title
          title: Text("Quotes Daily"),
        ),
        body: Padding(
          // Proses menampilkan data dari QuoteModel.
          padding: EdgeInsets.all(20),
          child: Center(
            child: FutureBuilder(
              future: get_data(),
              builder: (context, snapshot) {
                // Check jika data null maka tampilkan loading... .
                if (snapshot.data == null) {
                  return Text('Loading...');
                } else {
                  // Jika data tidak null maka tampilkan data content ke body screen
                  return Text(snapshot.data.content);
                }
              },
            ),
          ),
        ));
  }
}
