import 'dart:async';
import 'package:path/path.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:sqflite/sqflite.dart';

final String replsTable = "replacements";
final String replsColumnId = "id";
final String replsColumnVer = "ver";
final String replsColumnNumber = "number";
final String replsColumnFirstNumber = "first_number";
final String replsColumnLastNumber = "last_number";
final String replsColumnReplacement = "replacement";
final String replsColumnDefaultInteger = "default_integer";
final String replsColumnClassNumber = "class_number";

class ReplacementsProvider {
  Database db;

  ReplacementsProvider(this.db);

  Future<bool> insert(Map<String, dynamic> replacementItemMap) async {
    await db.insert(replsTable, replacementItemMap);
    return true;
  }

  Future<bool> insertAll(ReplacementsModel replacementsModel) async {
    replacementsModel.replacements.forEach((replacementItemModel) async {
      await insert(replacementItemModel.toMap(setFirstNumber: '0', setLastNumber: '0'));
    });
    return true;
  }

  Future<ReplacementItemModel> getReplacementItem(int id) async {
    List<Map> maps = await db.query(replsTable,
        columns: [replsColumnId, replsColumnVer, replsColumnNumber, replsColumnFirstNumber, replsColumnLastNumber, replsColumnReplacement, replsColumnDefaultInteger,replsColumnClassNumber],
        where: "$replsColumnId = ?",
        whereArgs: [id]
    );
    if (maps.length > 0) {
      return ReplacementItemModel.fromMap(maps.first);
    }
    return null;
  }

  Future<ReplacementsModel> getAllReplacements() async {
    List<Map> replacementsMap = await db.query(replsTable,
      columns: [replsColumnId, replsColumnVer, replsColumnNumber, replsColumnFirstNumber, replsColumnLastNumber, replsColumnReplacement, replsColumnDefaultInteger,replsColumnClassNumber],
    );
    var map = <String, dynamic>{
      'replacements': replacementsMap,
      'ids': null,
    };
    if (replacementsMap.length > 0) {
      return ReplacementsModel.fromMap(map);
    }
    return null;
  }

  Future<int> delete(int id) async {
    return await db.delete(replsTable, where: "$replsColumnId = ?", whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db.delete(replsTable);
  }
}