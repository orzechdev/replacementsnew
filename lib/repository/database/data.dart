import 'dart:async';
import 'package:replacements/repository/models/data_model.dart';
import 'package:sqflite/sqflite.dart';

final String dataTable = "data";
final String dataColumnId = "id";
final String dataColumnVer = "ver";
final String dataColumnName = "name";
final String dataColumnType = "type";
final String dataColumnSelected = "selected";

class DataProvider {
  Database db;

  DataProvider(this.db);

  Future<bool> insert(Map<String, dynamic> dataItemMap) async {
    await db.insert(dataTable, dataItemMap);
    return true;
  }

  Future<bool> insertAll(DataModel dataModel) async {
    dataModel.classes.forEach((dataItemModel) async {
      await insert(dataItemModel.toMap(setType: '0'));
    });
    dataModel.teachers.forEach((dataItemModel) async {
      await insert(dataItemModel.toMap(setType: '1'));
    });
    return true;
  }

  Future<DataItemModel> getDataItem(int id) async {
    List<Map> maps = await db.query(dataTable,
        columns: [dataColumnId, dataColumnVer, dataColumnName, dataColumnType, dataColumnSelected],
        where: "$dataColumnId = ?",
        whereArgs: [id]
    );
    if (maps.length > 0) {
      return DataItemModel.fromMap(maps.first);
    }
    return null;
  }

  Future<DataModel> getAllData() async {
    List<Map> classesMap = await db.query(dataTable,
      columns: [dataColumnId, dataColumnVer, dataColumnName, dataColumnType, dataColumnSelected],
      where: "$dataColumnType = ?",
      whereArgs: ['0']
    );
    List<Map> teachersMap = await db.query(dataTable,
      columns: [dataColumnId, dataColumnVer, dataColumnName, dataColumnType, dataColumnSelected],
      where: "$dataColumnType = ?",
      whereArgs: ['1']
    );
    var map = <String, dynamic>{
      'classes': classesMap,
      'teachers': teachersMap,
      'ids_classes': null,
      'ids_teachers': null,
    };
    if (classesMap.length > 0) {
      return DataModel.fromMap(map);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(dataTable, where: "$dataColumnId = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db.delete(dataTable);
  }

  Future<int> update(DataItemModel dataItemModel) async {
    return await db.update(dataTable, dataItemModel.toMap(),
        where: "$dataColumnId = ?", whereArgs: [dataItemModel.id]);
  }
}
