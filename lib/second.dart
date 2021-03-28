import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class Data {
  Map fetched_data = {
    "data": [
      {"id": 111, "name": "abc"},
      {"id": 222, "name": "pqr"},
      {"id": 333, "name": "abc"}
    ]
  };
  List _data;

//function to fetch the data

  Data() {
    _data = fetched_data["data"];
  }

  int getId(int index) {
    return _data[index]["id"];
  }

  String getName(int index) {
    return _data[index]["name"];
  }

  int getLength() {
    return _data.length;
  }
}

class _HomeState extends State<Home> {
  Data _data = new Data();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: ListView.builder(
          padding: const EdgeInsets.all(5.5),
          itemCount: _data.getLength(),
          itemBuilder: _itemBuilder,
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return InkWell(
      child: Card(
        child: Center(
          child: Text(
            "${_data.getName(index)}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.orange,
            ),
          ),
        ),
      ),
      // onTap: () => MaterialPageRoute(
      //     builder: (context) =>
      //         SecondRoute(id: _data.getId(index), name: _data.getName(index))),
    );
  }
}
