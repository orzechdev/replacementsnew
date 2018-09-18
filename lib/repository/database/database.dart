import 'dart:async';
import 'package:path/path.dart';
import 'package:replacements/repository/database/data.dart';
import 'package:replacements/repository/database/replacements.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

Future<String> getDatabasePath() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, "replacements.db");
  return path;
}

class DatabaseHelper {
  Database _db;
  final _lock = Lock();
  DataProvider dataProvider;
  ReplacementsProvider replacementsProvider;

  Future<bool> open(String path) async {
    if (_db == null) {
      await _lock.synchronized(() async {
        _db = await openDatabase(
          path,
          version: 9,
          onUpgrade: (Database db, int oldVersion, int newVersion) async {
            await db.execute('''
              drop table if exists $replsTable
              ''');
            await db.execute('''
              drop table if exists $dataTable
              ''');
            await db.execute('''
              create table $dataTable ( 
                $dataColumnId text primary key, 
                $dataColumnVer text not null,
                $dataColumnName text not null,
                $dataColumnType text not null,
                $dataColumnSelected text not null)
              ''');
            await db.execute('''
              create table $replsTable ( 
                $replsColumnId text primary key, 
                $replsColumnVer text not null,
                $replsColumnNumber text,
                $replsColumnFirstNumber text,
                $replsColumnLastNumber text,
                $replsColumnReplacement text not null,
                $replsColumnDefaultInteger text,
                $replsColumnClassNumber text)
              ''');
          },
          onCreate: (Database db, int version) async {
            await db.execute('''
              create table $dataTable ( 
                $dataColumnId text primary key, 
                $dataColumnVer text not null,
                $dataColumnName text not null,
                $dataColumnType text not null,
                $dataColumnSelected text not null)
              ''');
            await db.execute('''
              create table $replsTable ( 
                $replsColumnId text primary key, 
                $replsColumnVer text not null,
                $replsColumnNumber text,
                $replsColumnFirstNumber text,
                $replsColumnLastNumber text,
                $replsColumnReplacement text not null,
                $replsColumnDefaultInteger text,
                $replsColumnClassNumber text)
              ''');
          }
        );
      });
    }
    return true;
  }

  Future close() async => _db.close();

  DataProvider getDataProvider() {
    if (dataProvider == null) {
      dataProvider = DataProvider(_db);
    }
    return dataProvider;
  }

  ReplacementsProvider getReplacementsProvider() {
    if (replacementsProvider == null) {
      replacementsProvider = ReplacementsProvider(_db);
    }
    return replacementsProvider;
  }
}