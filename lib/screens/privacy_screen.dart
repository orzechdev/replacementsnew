import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_text.dart';
import 'package:replacements/consts.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polityka Prywatności'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: HtmlText(
          data: privacyPolicyText
        ),
      ),
    );
  }
}
