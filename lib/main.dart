import 'package:flutter/material.dart';
import 'package:replacements/repository/repository.dart';
import 'package:replacements/screens/home_screen.dart';
import 'package:replacements/config.dart';

import 'package:flutter/rendering.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  Repository repository;

  App() {
    repository = Repository();
    // Database is never closed... TODO: todo or not todo...
  }

  @override
  Widget build(BuildContext context) {
    if (config['debugPaintSizeEnabled']) debugPaintSizeEnabled = true;

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
