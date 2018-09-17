import 'dart:async';

import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/repository/webService.dart';

class Repository {
  static final Repository _singleton = new Repository._internal();
  factory Repository() {
    return _singleton;
  }
  Repository._internal();

  DataModel date;
  ReplacementsModel replacements;

  Future<DataModel> getData() async {
    if (date == null) {
      print('#### Repository getReplacements date is null');
      return await fetchData();
    } else {
      print('#### Repository getReplacements date not null');
      return date;
    }
  }

  Future<ReplacementsModel> getReplacements() async {
    if (replacements == null) {
      print('#### Repository getReplacements replacements is null');
      return await fetchReplacements();
    } else {
      print('#### Repository getReplacements replacements not null');
      return replacements;
    }
  }
}
