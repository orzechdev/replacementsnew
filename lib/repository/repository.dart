import 'dart:async';

import 'package:replacements/repository/database/data.dart';
import 'package:replacements/repository/database/database.dart';
import 'package:replacements/repository/database/replacements.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/repository/webService.dart';
import 'package:synchronized/synchronized.dart';

class Repository {
  static final Repository _singleton = new Repository._internal();
  factory Repository() {
    return _singleton;
  }
  Repository._internal();

  openDatabase() async {
    print('#### Repository openDatabase');
    if (_databaseHelper == null) {
      print('#### Repository openDatabase dataProvider is null');
      _databaseHelper = DatabaseHelper();
      await _databaseHelper.open(await getDatabasePath());
      _dataProvider = _databaseHelper.getDataProvider();
      _replacementsProvider = _databaseHelper.getReplacementsProvider();
    }
  }

  DatabaseHelper _databaseHelper;
  DataProvider _dataProvider;
  ReplacementsProvider _replacementsProvider;
  DataModel _data;
  ReplacementsModel _replacements;

  Future<DataModel> getData() async {
    var lock = Lock();
    return await lock.synchronized(() async {
      if (_data == null) {
        print('#### Repository getData data is null');
        DataModel dataFetched = await fetchData();
        print('#### Repository getData data is null 1');
        int dataDeleted = await _dataProvider.deleteAll();
        print('#### Repository getData data is null 2');
        bool dataStored = await _dataProvider.insertAll(dataFetched);
        print('#### Repository getData data is null 3');
        _data = await _dataProvider.getAllData();
        print('#### Repository getData data is null 4');
        return _data;
      } else {
        print('#### Repository getData data not null');
        return _data;
      }
    });
  }

  Future<ReplacementsModel> getReplacements() async {
    var lock = Lock();
    return await lock.synchronized(() async {
      if (_replacements == null) {
        print('#### Repository getReplacements replacements is null');
        ReplacementsModel replacementsFetched = await fetchReplacements();
        print('#### Repository getReplacements replacements is null 1');
        int replacementsDeleted = await _replacementsProvider.deleteAll();
        print('#### Repository getReplacements replacements is null 2');
        bool replacementsStored = await _replacementsProvider.insertAll(replacementsFetched);
        print('#### Repository getReplacements replacements is null 3');
        _replacements = await _replacementsProvider.getAllReplacements();
        print('#### Repository getReplacements replacements is null 4');
        return _replacements;
      } else {
        print('#### Repository getReplacements replacements not null');
        return _replacements;
      }
    });
  }
}
