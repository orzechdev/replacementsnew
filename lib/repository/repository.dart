import 'dart:async';

import 'package:replacements/repository/database/data.dart';
import 'package:replacements/repository/database/database.dart';
import 'package:replacements/repository/database/replacements.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/repository/webService.dart';
import 'package:synchronized/synchronized.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  static final Repository _singleton = new Repository._internal();
  factory Repository() {
    return _singleton;
  }
  Repository._internal();

  openRepository() async {
    var lock = Lock();
    return await lock.synchronized(() async {
      print('#### Repository openRepository');
      if (_databaseHelper == null) {
        sharedPreferences = await SharedPreferences.getInstance();
        print('#### Repository openRepository dataProvider is null');
        _databaseHelper = DatabaseHelper();
        await _databaseHelper.open(await getDatabasePath());
        _dataProvider = _databaseHelper.getDataProvider();
        _replacementsProvider = _databaseHelper.getReplacementsProvider();
        return true;
      }
      return true;
    });
  }

  SharedPreferences sharedPreferences;
  DatabaseHelper _databaseHelper;
  DataProvider _dataProvider;
  ReplacementsProvider _replacementsProvider;
  DataModel _data;
  ReplacementsModel _replacements;

  Future<DataModel> getData() async {
    var lock = Lock();
    return await lock.synchronized(() async {
      print('#### Repository getData');
      if (_data == null) {
        print('#### Repository getData DB data is null');
        _data = await _dataProvider.getAllData();
        if (_data == null) {
          print('#### Repository getData FETCH data is null');
          DataModel dataFetched = await fetchData();
          print('#### Repository getData FETCH data is null 1');
          int dataDeleted = await _dataProvider.deleteAll();
          print('#### Repository getData FETCH data is null 2');
          bool dataStored = await _dataProvider.insertAll(dataFetched);
          print('#### Repository getData FETCH data is null 3');
          _data = await _dataProvider.getAllData();
          print('#### Repository getData FETCH data is null 4');
          return _data;
        } else {
          print('#### Repository getData DB data not null');
          return _data;
        }
      } else {
        print('#### Repository getData data not null DB');
        return _data;
      }
    });
  }

  Future<bool> setData(DataModel dataModel, bool notifyReplacements, bool notifyReplacementsJustForData) async {
    var lock = Lock();
    return await lock.synchronized(() async {
      if (dataModel == null) {
        print('#### Repository setData 1-2');
        dataModel = await _dataProvider.getAllData();
      } else {
        print('#### Repository setData 1');
        int dataDeleted = await _dataProvider.deleteAll();
        print('#### Repository setData 2');
        bool dataStored = await _dataProvider.insertAll(dataModel);
      }
      print('#### Repository setData 3');
      sharedPreferences.setBool('todoUpdateProfile', true);
      print('#### Repository setData 4');
      String fcmToken = 'm9834mcb48fmff4f34f34';
      List<String> dataIds = ['12', '14', '38'];
      //bool notifyReplacements = true;
      //bool notifyReplacementsJustForData = true;
      print('#### Repository setData 5');
      bool response = await setProfile(fcmToken, dataIds, notifyReplacements, notifyReplacementsJustForData);
      print('#### Repository setData 6');
      return response;
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
