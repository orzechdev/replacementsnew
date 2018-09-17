import 'package:flutter/material.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/repository/repository.dart';
import 'package:replacements/widgets/replacements_list.dart';

class Home extends StatefulWidget {
  Repository repository;

  Home({
    this.repository,
  });

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
  DataModel _data;
  ReplacementsModel _replacements;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      getDataFromRepo();
    }
    if (_replacements == null) {
      getReplacementsFromRepo();
    }
    List<Widget> _children = [
      Center(
        child: Text(_childrenTitles[0]),
      ),
      ReplacementsList(
        data: _data,
        replacements: _replacements,
      ),
      Center(
        child: Text(_childrenTitles[2]),
      ),
    ];
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

  void getReplacementsFromRepo() async {
    var replacementsFromRepository;
    try {
      replacementsFromRepository = await widget.repository.getReplacements();
      print(replacementsFromRepository);
    } catch (e) {
      print(e);
      // TODO Handle error...
    }
    setState(() {
      _replacements = replacementsFromRepository;
    });
  }

  void getDataFromRepo() async {
    var dataFromRepository;
    try {
      dataFromRepository = await widget.repository.getData();
      print(dataFromRepository);
    } catch (e) {
      print(e);
      // TODO Handle error...
    }
    setState(() {
      _data = dataFromRepository;
    });
  }
}
