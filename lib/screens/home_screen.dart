import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [Center(child: Text('Plan')), Center(child: Text('Zastępstwa')), Center(child: Text('Preferencje'))];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zastępstwa'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            title: Text('Plan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Zastępstwa'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            title: Text('Preferencje'),
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
