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
    List<DataItemModel> dataAll = List();
    String title;
    if (type == 'classes') {
      dataAll = _data.classes.map((item) => DataItemModel.clone(item)).toList();
      title = 'Wybieranie klas';
    } else if (type == 'teachers') {
      dataAll = _data.teachers.map((item) => DataItemModel.clone(item)).toList();
      title = 'Wybieranie nauczycieli';
    }
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: ClassTeacherListDialogContent(
            data: dataAll
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
                if (type == 'classes') {
                  _data.classes = dataAll;
                } else if (type == 'teachers') {
                  _data.teachers = dataAll;
                }
                // TODO Saving data in the database and try send them to the server
                // (better create service connecting with server in another thread)
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
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

class ClassTeacherListDialogContent extends StatefulWidget {
  List<dynamic> data;

  ClassTeacherListDialogContent({
    this.data,
  });

  @override
  State<StatefulWidget> createState() => ClassTeacherListDialogContentState();
}

class ClassTeacherListDialogContentState extends State<ClassTeacherListDialogContent> {
  List<dynamic> _data;

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      _data = widget.data;
    }
    return SingleChildScrollView(
      child: ListBody(
        children: _data.map((dynamic dataItem) {
          return _selectionListItem(dataItem, _data);
        }).toList(),
      ),
    );
  }

  CheckboxListTile _selectionListItem(DataItemModel dataItem, List<DataItemModel> data) {
    return CheckboxListTile(
      title: Text(dataItem.name),
      value: dataItem.selected != null ? dataItem.selected == '1' ? true : false : false,
      onChanged: (value) {
        print('${dataItem.id} - ${value.toString()}');
        setState(() {
          dataItem.selected = dataItem.selected == '1' ? '0' : '1';
//          data.forEach((DataItemModel dataItemFromAll) {
//            if (dataItemFromAll.id == dataItem.id) {
//              dataItemFromAll.selected = dataItem.selected;
//              return;
//            }
//          });
        });
      },
    );
  }
}
