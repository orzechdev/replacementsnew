import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  static List<String> _childrenTitles = [
    'Plan',
    'Zastępstwa',
    'Preferencje',
  ];
  final List<Widget> _children = [
    Center(
      child: Text(_childrenTitles[0]),
    ),
    Center(
      child: Text(_childrenTitles[1]),
    ),
    Center(
      child: Text(_childrenTitles[2]),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_childrenTitles[_currentIndex]),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text(_childrenTitles[0]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text(_childrenTitles[1]),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            title: Text(_childrenTitles[2]),
          )
        ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
