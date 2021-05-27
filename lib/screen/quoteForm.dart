import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuoteForm extends StatefulWidget {
  @override
  _QuoteFormState createState() => _QuoteFormState();
}

class _QuoteFormState extends State<QuoteForm> {
  final _formKey = GlobalKey<FormState>();

  /** Define attrbute quator, quote and quotes list */
  String quator = '';
  String quote = '';
  List quotes = [];

  /** Function for save data quote */
  saveQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode({'data': quotes});
    prefs.setString('data', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah quote"),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => {Navigator.pushNamed(context, '/')},
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Quote dari",
                      labelText: "Quote dari",
                      icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      quator = value;
                    }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    maxLength: 1000,
                    decoration: new InputDecoration(
                      hintText: "Quotes",
                      labelText: "Quotes",
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Quotes tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      quote = value;
                    }),
              ),
              RaisedButton(
                child: Text(
                  "Simpan Quote",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    /** get quotes before save and store to sharedPreferences */
                    quotes = (sharedPrefs.data != '')
                        ? jsonDecode(sharedPrefs.data)['data']
                        : [];
                    quotes.add({'quator': quator, 'quote': quote});

                    saveQuote();
                    Navigator.pushNamed(context, '/');
                    // Navigator.of(context).pushReplacement(
                    //     MaterialPageRoute(builder: (context) => QuoteList()));
                    // Navigator.pushReplacement(context, '/');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => QuoteList()),
                    // );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
