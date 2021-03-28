import 'dart:convert';

import 'package:flutter/material.dart';
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

  /** Function get creator of quote */
  String getQuator(int index) {
    return _data[index]["quator"];
  }

  /** Function get quote*/
  String getQuote(int index) {
    return _data[index]["quote"];
  }

  /** Function get for length of data */
  int getLength() {
    return _data.length;
  }

  /** Function get data by index and return as string */
  String getByIndex(index) {
    return jsonEncode(_data[index]);
  }

  /** Remove data and return current data after deleted*/
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

  /** Function for update data list on sharePreferences after removed */
  void updateData(newData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({'data': newData});
    prefs.setString('data', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quotes'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.home),
          ),
        ),
        body: Padding(
          child: ListView.builder(
            itemCount: _data.getLength(),
            itemBuilder: (context, index) {
              /** This for delete quote by slide right or left */
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
            Navigator.pushNamed(context, '/form');
          },
          tooltip: 'Tambah quote',
          child: Icon(Icons.add),
        ));
  }

  /** Widget for create card item quote */
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
          Navigator.pushNamed(context, '/show');
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
