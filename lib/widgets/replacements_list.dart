import 'dart:async';

import 'package:flutter/material.dart';
import 'package:replacements/repository/models/data_model.dart';
import 'package:replacements/repository/models/replacements_models.dart';
import 'package:replacements/repository/repository.dart';
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
        return ListTile(
          title: Text(findClass(_replacements.replacements[index].classNumber) + _replacements.replacements[index].replacement),
          subtitle: Text(findDefaultTeacher(_replacements.replacements[index].defaultInteger)),
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
