import 'package:flutter/material.dart';
import 'package:replacements/models/replacements_models.dart';
import 'package:replacements/widgets/date_day_selector.dart';

class ReplacementsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReplacementsListState();
}

class _ReplacementsListState extends State<ReplacementsList> {
  int _daysSinceSelected = 0;
  final ReplacementsModel _replacements = ReplacementsModel(
    [
      ReplacementModel(1, 'abcd', 'repl 1', 1, 26, 44), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77),
      ReplacementModel(1, 'abcd', 'repl 1', 1, 26, 44), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77),
      ReplacementModel(1, 'abcd', 'repl 1', 1, 26, 44), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77),
      ReplacementModel(1, 'abcd', 'repl 1', 1, 26, 44), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77),
      ReplacementModel(1, 'abcd', 'repl 1', 1, 26, 44), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77), ReplacementModel(2, 'ffss', 'repl 2', 2, 38, 77),
    ],
    [
      '133', '145'
    ]
  );

  @override
  Widget build(BuildContext context) {
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
          title: Text(_replacements.replacements[index].replacement),
          subtitle: Text(_replacements.replacements[index].defaultInteger.toString()),
        );
      },
    );
  }

  void _changeDate(DateTime dateTime) {
    setState(() {

    });
  }
}
