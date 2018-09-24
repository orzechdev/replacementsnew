import 'package:flutter/material.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/widgets/date_day_selector.dart';

class ReplacementsList extends StatefulWidget {
  ReplacementsModel replacements;
  DataModel data;

  ReplacementsList({
    this.data,
    this.replacements,
  });

  @override
  State<StatefulWidget> createState() => _ReplacementsListState();
}

class _ReplacementsListState extends State<ReplacementsList> {
  ReplacementsModel _replacements;
  DataModel _data;

  @override
  Widget build(BuildContext context) {
    if (_replacements == null) {
      _replacements = widget.replacements;
    }
    if (_data == null) {
      _data = widget.data;
    }
    if (_data != null && _replacements != null) {
    }
    return ListView.builder(
      itemCount: _replacements == null ? 1 : _replacements.replacements.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return DateDaySelector(
            onDateChanged: _changeDate,
          );
        }
        index -= 1;
        final indexWithoutDivider = index ~/ 2;
        if (index.isEven) return Divider(
          height: 0.0,
        );
        return ListTile(
//          leading: Container(
//            width: 7.0,
//            height: 70.0,
//            color: Color(0xFF216CC7),
//          ),
          title: Text(
            findClass(_replacements.replacements[index].classNumber) + _replacements.replacements[index].replacement,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
          subtitle: Text(
            findDefaultTeacher(_replacements.replacements[index].defaultInteger),
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          //contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
        );
      },
    );
  }

  void _changeDate(DateTime dateTime) {
    setState(() {

    });
  }

  String findClass(id) {
    for (var dataItem in _data.classes) {
      if (id == dataItem.id) {
        return '${dataItem.name} - ';
      }
    }
    return '';
  }

  String findDefaultTeacher(id) {
    for (var dataItem in _data.teachers) {
      if (id == dataItem.id) {
        return 'Za ${dataItem.name}';
      }
    }
    return id.toString();
  }
}
