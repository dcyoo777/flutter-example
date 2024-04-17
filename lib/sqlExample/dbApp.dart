import 'package:flutter/material.dart';
import 'package:my_app/sqlExample/todo.dart';
import 'package:sqflite/sqflite.dart';

class DBApp extends StatefulWidget {
  final Future<Database> db;

  DBApp(this.db);

  @override
  State<StatefulWidget> createState() => _DBApp();
}

class _DBApp extends State<DBApp> {
  Future<List<Todo>>? todoList;

  @override
  void initState() {
    super.initState();
    todoList = getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed('/clear');
              setState(() {
                todoList = getTodos();
              });
            },
            child: Text('완료한 일', style: TextStyle(color: Colors.black))
          )
        ]
      ),
      body: Container(
          child: Center(
              child: FutureBuilder(
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: (snapshot.data as List<Todo>).length,
                  itemBuilder: (context, index) {
                    Todo todo = (snapshot.data as List<Todo>)[index];
                    return ListTile(
                      title: Text(todo.title!, style: TextStyle(fontSize: 20)),
                      subtitle: Container(
                          child: Column(
                        children: <Widget>[
                          Text(todo.content!),
                          Text('체크 : ${todo.active == 1 ? 'true' : 'false'}'),
                          Container(
                            height: 1,
                            color: Colors.blue,
                          )
                        ],
                      )),
                      onTap: () async {
                        TextEditingController controller =
                            new TextEditingController(text: todo.content);

                        Todo result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('${todo.id} : ${todo.title}'),
                                content: TextField(
                                  controller: controller,
                                  keyboardType: TextInputType.text,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      todo.active == 1
                                          ? todo.active = 0
                                          : todo.active = 1;
                                      todo.content = controller.value.text;
                                      Navigator.of(context).pop(todo);
                                    },
                                    child: Text("예"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(todo);
                                    },
                                    child: Text("아니오"),
                                  ),
                                ],
                              );
                            });
                        _updateTodo(result);
                      },
                      onLongPress: () async {
                        Todo result = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('${todo.id} : ${todo.title}'),
                                content: Text('${todo.content}를 삭제하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(todo);
                                      },
                                      child: Text('예')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('아니오')),
                                ],
                              );
                            });
                        _deleteTodo(result);
                      },
                    );
                  },
                );
              } else {
                return Text('No data');
              }
          }
        },
        future: todoList,
      ))),
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add');
              if (todo != null) {
                _insertTodo(todo as Todo);
              }
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: () async {
              _allUpdate();
            },
            heroTag: null,
            child: Icon(Icons.update),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  void _insertTodo(Todo todo) async {
    final Database db = await widget.db;
    await db.insert('todos', todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database db = await widget.db;
    await db.update(
      'todos',
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _deleteTodo(Todo todo) async {
    final Database db = await widget.db;
    await db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [todo.id],
    );
    setState(() {
      todoList = getTodos();
    });
  }

  void _allUpdate() async {
    final Database db = await widget.db;
    await db.rawQuery('update todos set active = 1 where active = 0');
    setState(() {
      todoList = getTodos();
    });
  }

  Future<List<Todo>> getTodos() async {
    final Database db = await widget.db;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (index) {
      int active = maps[index]['active'] == 1 ? 1 : 0;
      return Todo(
        title: maps[index]['title'].toString(),
        content: maps[index]['content'].toString(),
        active: active,
        id: maps[index]['id'],
      );
    });
  }
}
