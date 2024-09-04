import 'package:flutter/material.dart';
import 'package:job_task/pages/ParsedDataPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: JsonParserPage(),
    );
  }
}
