import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

typedef void DateChangedCallback(DateTime dateTime);

class DateDaySelector extends StatefulWidget {
  final DateTime initialSelectedDate;
  final DateTime todayDate;
  final DateChangedCallback onDateChanged;

  DateDaySelector({
    this.initialSelectedDate,
    this.todayDate,
    this.onDateChanged,
  });

  @override
  State<StatefulWidget> createState() => _DateDaySelectorState();
}

class _DateDaySelectorState extends State<DateDaySelector> {
  DateTime _todayDate;
  DateTime _selectedDate;
  DateFormat _dateFormatter = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    if (_todayDate == null) {
      _todayDate = widget.todayDate != null ? widget.todayDate : DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    }
    if (_selectedDate == null) {
      _selectedDate = widget.initialSelectedDate != null ? widget.initialSelectedDate : _todayDate;
    }
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = _todayDate.subtract(Duration(days: 1));
              });
            },
            child: _DateDaySelectorItem(
              isSelected: _selectedDate == _todayDate.subtract(Duration(days: 1)),
              title: 'Wczoraj',
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = _todayDate;
              });
            },
            child: _DateDaySelectorItem(
              isSelected: _selectedDate == _todayDate,
              title: 'Dzisiaj',
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = _todayDate.add(Duration(days: 1));
              });
            },
            child: _DateDaySelectorItem(
              isSelected: _selectedDate == _todayDate.add(Duration(days: 1)),
              title: 'Jutro',
            ),
          ),
          GestureDetector(
            onTap: () {
              selectDateFromPicker();
            },
            child: _DateDaySelectorItem(
              isSelected: _selectedDate.isBefore(_todayDate.subtract(Duration(days: 1))) || _selectedDate.isAfter(_todayDate.add(Duration(days: 1))),
              title: _dateFormatter.format(_selectedDate),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> selectDateFromPicker() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: _todayDate.subtract(Duration(days: 365 * 100)),
      lastDate: _todayDate.add(Duration(days: 365 * 100)),
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }
}

class _DateDaySelectorItem extends StatelessWidget {
  final bool isSelected;
  final String title;

  _DateDaySelectorItem({Key key, this.isSelected: false, this.title})
      : assert(() {
          if (title == null) {
            throw new FlutterError('Incorrect DateDaySelector arguments.\n'
                'You must specify title.');
          }
          return true;
        }()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isSelected ? 18.0 : 16.0,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w400,
          color: isSelected ? Color(0xFF216CC7) : Colors.black,
        ),
      ),
    );
  }
}
