import 'dart:async';
import 'package:replacements/screens/privacy_screen.dart';
import 'package:url_launcher/url_launcher.dart';
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
  bool _notificationsReplacements;
  bool _notificationsSelectedTeachersClasses;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      _data = widget.data;
    }
    if (_notificationsSelectedTeachersClasses == null) {
      _notificationsSelectedTeachersClasses = true;
    }
    if (_notificationsReplacements == null) {
      _notificationsReplacements = true;
    }
    return ListView(
      children: [
        ListTile(
          title: Text(
            'Personalizacja',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        ListTile(
          leading: Icon(Icons.group_work),
          title: Text('Wybrane klasy'),
          subtitle: Text('Brak'),
          onTap: () {
            _selectPreferenceItems(context, 'classes');
          },
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text('Wybrani nauczyciele'),
          subtitle: Text('Brak'),
          onTap: () {
            _selectPreferenceItems(context, 'teachers');
          },
        ),
        SwitchListTile(
          secondary: Icon(Icons.notifications),
          title: Text('Powiadomienia o zastępstwach'),
          value: _notificationsReplacements,
          onChanged: (bool value) {
            setState(() {
              _notificationsReplacements = value;
            });
          },
        ),
        SwitchListTile(
          secondary: Icon(Icons.notifications),
          title: Text('Powiadomienia o zastępstwach tylko dla wybranych klas i nauczycieli'),
          value: _notificationsSelectedTeachersClasses,
          onChanged: (bool value) {
            setState(() {
              _notificationsSelectedTeachersClasses = value;
            });
          },
        ),
        ListTile(
          title: Text(
            'Informacje',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        ListTile(
          leading: Icon(Icons.assignment),
          title: Text('Polityka Prywatności'),
          onTap: () {
            _openPrivacyPolicy(context);
          },
        ),
      ]
    );
  }

  Future<void> _selectPreferenceItems(context, type) async {
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
                return _selectionListItem(dataItem);
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

  CheckboxListTile _selectionListItem(DataItemModel dataItem) {
    return CheckboxListTile(
      title: Text(dataItem.name),
      value: dataItem.selected != null ? dataItem.selected == '1' ? true : false : false,
      onChanged: (value) {
        print('${dataItem.id} - ${value.toString()}');
      },
    );
  }

  _openPrivacyPolicy(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacyScreen(),
      )
    );
  }
}
