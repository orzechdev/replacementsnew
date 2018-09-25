import 'dart:async';

import 'package:flutter/material.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/repository/repository.dart';
import 'package:replacements/widgets/preference_list.dart';
import 'package:replacements/widgets/replacements_list.dart';
import 'package:connectivity/connectivity.dart';

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
  bool _loadingData = true;
  bool _loadingReplacements = true;
  bool _needOpenRepository = true;
  bool _isInternetConnection;
  StreamSubscription<ConnectivityResult> connectivityListener;

  @override
  initState() {
    super.initState();
    connectivityListener = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        setState(() {
          _isInternetConnection = true;
        });
      } else {
        setState(() {
          _isInternetConnection = false;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  dispose() {
    connectivityListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_needOpenRepository) {
      openRepository();
      return _showLoading();
    }
    if (_data == null) {
      getDataFromRepo();
    }
    if (_replacements == null) {
      getReplacementsFromRepo();
    }
    if (_loadingData || _loadingReplacements || _isInternetConnection == null) {
      return _showLoading();
    } else {
      List<Widget> _children = [
        Center(
          child: Text(_childrenTitles[0]),
        ),
        ReplacementsList(
          data: _data,
          replacements: _replacements,
        ),
        PreferenceList(
          data: _data,
          onDataChanged: _setDataInRepo,
          isInternetConnection: _isInternetConnection,
        )
      ];
      return Scaffold(
        appBar: AppBar(
          title: Text(_childrenTitles[_currentIndex]),
          centerTitle: true,
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
  }

  void openRepository() async {
    bool repositoryState = await widget.repository.openRepository();
    setState(() {
      _needOpenRepository = !repositoryState;
    });
  }

  Widget _showLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
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
      setState(() {
        _replacements = replacementsFromRepository;
        _loadingReplacements = false;
      });
    } catch (e) {
      print(e);
      // TODO Handle error...
    }
  }

  void getDataFromRepo() async {
    var dataFromRepository;
    try {
      dataFromRepository = await widget.repository.getData();
      print(dataFromRepository);
      setState(() {
        _data = dataFromRepository;
        _loadingData = false;
      });
    } catch (e) {
      print(e);
      // TODO Handle error...
    }
  }

  void _setDataInRepo(DataModel dataModel) async {
    var dataSavedInRepository;
    try {
      dataSavedInRepository = await widget.repository.setData(dataModel);
      print('_setDataInRepo: ' + dataSavedInRepository);
    } catch (e) {
      print(e);
      // TODO Handle error...
    }
  }
}
