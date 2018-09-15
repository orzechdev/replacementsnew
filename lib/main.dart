import 'package:flutter/material.dart';
import 'package:replacements/screens/home_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zastępstwa',
      home: Home(),
    );
  }
}
