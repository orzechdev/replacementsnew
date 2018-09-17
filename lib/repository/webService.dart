import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';

Future<DataModel> fetchData() async {
  final response = await http.get('http://zschocianow.pl/json/replacements-data.php?ver=0');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    print(response.body);
    return DataModel.fromMap(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<ReplacementsModel> fetchReplacements() async {
  final response = await http.get('http://zschocianow.pl/json/replacements.php?date=2015-09-25');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    print(response.body);
    return ReplacementsModel.fromMap(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load data');
  }
}
