import 'package:flutter/material.dart';
import 'package:my_app/sqlExample/dbApp.dart';
import 'package:my_app/sqlExample/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ClearListApp extends StatefulWidget {
  final Future<Database> db;

  ClearListApp(this.db);

  @override
  State<StatefulWidget> createState() => _ClearListApp();
}

class _ClearListApp extends State<ClearListApp> {
  Future<List<Todo>>? clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('완료한 일')),
        body: Container(child: Center(child: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Todo todo = (snapshot.data as List<Todo>)[index];
                      return ListTile(
                        title:
                            Text(todo.title!, style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                            child: Column(
                          children: <Widget>[
                            Text(todo.content!),
                            Container(
                              height: 1,
                              color: Colors.blue,
                            )
                          ],
                        )),
                      );
                    },
                    itemCount: (snapshot.data as List<Todo>).length,
                  );
                }
            }
            return Text('No data');
          },
          future: clearList,
        ))));
  }

  Future<List<Todo>> getClearList() async {
    final db = await widget.db;
    List<Map<String, dynamic>> maps = await db
        .rawQuery('select title, content, id from todos where active=1');

    return List.generate(maps.length, (index) {
      return Todo(
        title: maps[index]['title'].toString(),
        content: maps[index]['content'].toString(),
        id: maps[index]['id'],
      );
    });
  }
}
