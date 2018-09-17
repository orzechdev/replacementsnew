import 'dart:async';
import 'package:replacements/repository/models/data_model.dart';
import 'package:sqflite/sqflite.dart';

final String dataTable = "data";
final String dataColumnId = "_id";
final String dataColumnType = "type";
final String dataColumnName = "name";
final String dataColumnSelected = "selected";

final String replsTable = "replacements";
final String replsColumnId = "_id";
final String replsColumnVer = "ver";
final String replsColumnNumber = "number";
final String replsColumnFirstNumber = "first_number";
final String replsColumnLastNumber = "last_number";
final String replsColumnReplacement = "replacement";
final String replsColumnDefaultInteger = "default_integer";
final String replsColumnClassNumber = "class_number";

class DataProvider {
  Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          create table $dataTable ( 
            $dataColumnId integer primary key, 
            $dataColumnType integer not null,
            $dataColumnName text not null,
            $dataColumnSelected text not null)
          ''');
      }
    );
  }

  Future<DataItemModel> insert(DataItemModel dataItemModel) async {
    //TODO
    //dataItemModel.id = await db.insert(dataTable, dataItemModel.toMap());
    return dataItemModel;
  }
}
