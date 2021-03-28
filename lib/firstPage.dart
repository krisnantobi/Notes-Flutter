import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Belajar Form Flutter",
    home: BelajarForm(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BelajarForm()),
            );
          },
        ),
      ),
    );
  }
}

class BelajarForm extends StatefulWidget {
  @override
  _BelajarFormState createState() => _BelajarFormState();
}

class _BelajarFormState extends State<BelajarForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes.me"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
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
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
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
                ),
              ),
              RaisedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
              ),
              ElevatedButton(
                child: Text('Open route'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirstRoute()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
