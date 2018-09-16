import 'package:flutter/material.dart';
import 'package:replacements/models/replacements_models.dart';

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
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _daysSinceSelected = -1;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Wczoraj',
                      style: TextStyle(
                        fontSize: _daysSinceSelected == -1 ? 18.0 : 16.0,
                        fontWeight: _daysSinceSelected == -1 ? FontWeight.w600 : FontWeight.w400,
                        color: _daysSinceSelected == -1 ? Color(0xFF216CC7) : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _daysSinceSelected = 0;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Dzisiaj',
                      style: TextStyle(
                        fontSize: _daysSinceSelected == 0 ? 18.0 : 16.0,
                        fontWeight: _daysSinceSelected == 0 ? FontWeight.w600 : FontWeight.w400,
                        color: _daysSinceSelected == 0 ? Color(0xFF216CC7) : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _daysSinceSelected = 1;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Jutro',
                      style: TextStyle(
                        fontSize: _daysSinceSelected == 1 ? 18.0 : 16.0,
                        fontWeight: _daysSinceSelected == 1 ? FontWeight.w600 : FontWeight.w400,
                        color: _daysSinceSelected == 1 ? Color(0xFF216CC7) : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _daysSinceSelected = 999;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Data',
                      style: TextStyle(
                        fontSize: _daysSinceSelected < -1 || _daysSinceSelected > 1 ? 18.0 : 16.0,
                        fontWeight: _daysSinceSelected < -1 || _daysSinceSelected > 1 ? FontWeight.w600 : FontWeight.w400,
                        color: _daysSinceSelected < -1 || _daysSinceSelected > 1 ? Color(0xFF216CC7) : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
}
