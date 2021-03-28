import 'package:flutter/material.dart';
import 'package:notes/routes.dart';
import 'package:notes/utils/shared_prefs.dart';

Future<void> main() async {
  await sharedPrefs.init();
  runApp(MaterialApp(
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
