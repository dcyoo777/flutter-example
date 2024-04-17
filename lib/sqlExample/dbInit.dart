import 'package:flutter/material.dart';
import 'package:my_app/sqlExample/clearList.dart';
import 'package:my_app/sqlExample/dbApp.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'addTodoApp.dart';

class DBInit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();

    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => DBApp(database),
        '/add': (context) => AddTodoApp(database),
        '/clear': (context) => ClearListApp(database),
      },
    );
  }

  Future<Database> initDatabase() async{
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, active INTEGER)"
        );
      },
      version: 1
    );
  }
}
