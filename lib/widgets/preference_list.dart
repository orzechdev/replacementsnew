import 'dart:async';

import 'package:flutter/material.dart';
import 'package:replacements/repository/models/data_model.dart';

class PreferenceList extends StatefulWidget {
  DataModel data;

  PreferenceList({
    this.data,
  });

  @override
  State<StatefulWidget> createState() => PreferenceListState();
}

class PreferenceListState extends State<PreferenceList> {
  DataModel _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      _data = widget.data;
    }
    return ListView(
      children: [
        ListTile(
          title: Text('Powiadomienia o zastępstwach dla wybranych klas i nauczycieli'),
          onTap: () {

          },
        ),
        ListTile(
          title: Text('Wybrane klasy'),
          subtitle: Text('Brak'),
          onTap: () {
            selectPreferenceItems(context, 'classes');
          },
        ),
        ListTile(
          title: Text('Wybrani nauczyciele'),
          subtitle: Text('Brak'),
          onTap: () {
            selectPreferenceItems(context, 'teachers');
          },
        )
      ]
    );
  }

  Future<void> selectPreferenceItems(context, type) async {
    List<dynamic> dataAll;
    String title;
    if (type == 'classes') {
      dataAll = _data.classes;
      title = 'Wybieranie klas';
    } else if (type == 'teachers') {
      dataAll = _data.teachers;
      title = 'Wybieranie nauczycieli';
    }
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: dataAll.map((dynamic dataItem) {
                return selectionListItem(dataItem);
              }).toList(),
            ),
          ),
          contentPadding: EdgeInsets.all(0.0),
          actions: <Widget>[
            FlatButton(
              child: Text("ANULUJ"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("ZAPISZ"),
              onPressed: () {

              },
            ),
          ],
        );
      }
    );
  }

  CheckboxListTile selectionListItem(dynamic dataItem) {
    return CheckboxListTile(
      title: Text(dataItem['name']),
      value: dataItem['selected'] != null ? dataItem['selected'] : false,
      onChanged: (value) {
        print('${dataItem['id']} - ${value.toString()}');
      },
    );
  }
}
