import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gson/gson.dart';
import 'package:notes/screen/quoteForm.dart';
import 'package:notes/screen/quoteShow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notes/utils/shared_prefs.dart';

// Classs ini digunakan untuk mengambil data
class Data {
  List _data;

  //function to fetch the data
  Data() {
    if (sharedPrefs.data != '') {
      _data = jsonDecode(sharedPrefs.data)['data'];
    } else {
      _data = [];
    }
  }

  /** Function ini digunakan untuk get quator/ quote creator */
  String getQuator(int index) {
    return _data[index]["quator"];
  }

  /** Function ini digunakan untuk get quote*/
  String getQuote(int index) {
    return _data[index]["quote"];
  }

  /** Function ini digunakan untuk mengambil panjang data */
  int getLength() {
    return _data.length;
  }

  /** Function ini digunakan untuk mengambil panjang data */
  String getByIndex(index) {
    return jsonEncode(_data[index]);
  }

  removeAt(index) {
    _data.removeAt(index);
    return _data;
  }
}

class QuoteList extends StatefulWidget {
  @override
  _QuoteListState createState() => _QuoteListState();
}

class _QuoteListState extends State<QuoteList> {
  /** Create object Data*/
  Data _data = new Data();

  void updateData(newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({'data': newData});
    prefs.setString('data', data);
  }

  /** Function ini digunakan untuk get quator/ quote creator */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quotes'),
        ),
        body: Padding(
          child: ListView.builder(
            itemCount: _data.getLength(),
            itemBuilder: (context, index) {
              return Dismissible(
                  key: Key(_data.getByIndex(index)),
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    padding: EdgeInsets.only(right: 40),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    final removeData = _data.removeAt(index);
                    setState(() => {removeData});
                    updateData(removeData);
                  },
                  child: _items(context, index));
            },
          ),
          padding: EdgeInsets.all(10),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuoteForm()),
            );
          },
          tooltip: 'Tambah quote',
          child: Icon(Icons.add),
        ));
  }

  Widget _items(BuildContext context, int index) {
    return InkWell(
      child: GestureDetector(
        onTap: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final data = jsonEncode({
            'quator': _data.getQuator(index),
            'quote': _data.getQuote(index),
          });
          prefs.setString('currentData', data);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QuoteShow()),
          );
        },
        child: Card(
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 70,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.amber[100],
                      width: 70,
                      height: 70,
                      child: Icon(Icons.bookmark, color: Colors.amber[700]),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_data.getQuote(index)),
                          Text("Oleh: " + _data.getQuator(index),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)))
                        ],
                      ),
                    ),
                    // Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
