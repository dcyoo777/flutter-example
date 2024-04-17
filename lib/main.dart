import 'package:flutter/material.dart';
import 'package:my_app/largeFileDownload/introPage.dart';
import 'package:my_app/largeFileDownload/logo.dart';
import 'package:my_app/sqlExample/dbApp.dart';
import 'package:my_app/sqlExample/dbInit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: DBInit()
    );
  }
}
