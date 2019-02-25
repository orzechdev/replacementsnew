import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

String selectedUrl = 'http://zschocianow.pl/plan/lista.html';

class ScheduleWebview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScheduleWebviewState();
}

class ScheduleWebviewState extends State<ScheduleWebview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InAppWebView(
        initialUrl: selectedUrl,
        initialOptions: {
          'useWideViewPort': false,
        },
      ),
    );
  }
}