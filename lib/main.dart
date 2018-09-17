import 'package:flutter/material.dart';
import 'package:replacements/repository/repository.dart';
import 'package:replacements/screens/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Repository repository;

  App() {
    repository = Repository();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zastępstwa',
      home: Home(
        repository: repository,
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF216CC7),
        accentColor: Color(0xFF216CC7),
      ),
    );
  }
}
