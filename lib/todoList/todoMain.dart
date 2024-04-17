import 'package:flutter/material.dart';
import 'package:my_app/todoList/secondDetail.dart';
import 'package:my_app/todoList/subDetail.dart';
import 'package:my_app/todoList/thirdDetail.dart';

class TodoMain extends StatelessWidget {
  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SubDetail(),
        '/second': (context) => SecondDetail(),
        '/third': (context) => ThirdDetail(),
      },
    );
  }
}
