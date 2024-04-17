import 'package:flutter/material.dart';

class SubDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SubDetail();
}

class _SubDetail extends State<SubDetail> {
  List<String> todoList = new List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList.add('당근 사오기');
    todoList.add('약 사오기');
    todoList.add('청소 하기');
    todoList.add('부모님께 전화하기');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sub Detail Example')),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                  child: Text(
                    todoList[index],
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/third', arguments: todoList[index]);
                  }),
            );
          },
          itemCount: todoList.length,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNavigation(context);
        },
        child: Icon(Icons.add)
      ),
    );
  }

  void _addNavigation(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/second');
    setState(() {
      todoList.add(result as String);
    });
  }
}
