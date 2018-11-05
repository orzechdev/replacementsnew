import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

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
          'userAgent': kAndroidUserAgent, // TODO Resizing doesn't work
        },
      ),
    );
  }
}