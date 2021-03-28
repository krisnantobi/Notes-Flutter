import 'package:flutter/material.dart';
import 'package:notes/screen/quoteList.dart';
import 'package:notes/screen/quoteForm.dart';

/**
 * Routes for navigate
 * Author: Krisnanto
 * Github: github.com/krisnantobi
 */
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => QuoteList());
      case '/about':
        return MaterialPageRoute(builder: (_) => QuoteForm());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text('Error page')),
      );
    });
  }
}
