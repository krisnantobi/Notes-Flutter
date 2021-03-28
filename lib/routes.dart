import 'package:flutter/material.dart';
import 'package:notes/screen/quoteList.dart';
import 'package:notes/screen/quoteForm.dart';
import 'package:notes/screen/quoteShow.dart';

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
      case '/form':
        return MaterialPageRoute(builder: (_) => QuoteForm());
      case '/show':
        return MaterialPageRoute(builder: (_) => QuoteShow());
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
