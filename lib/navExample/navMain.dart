import 'package:flutter/material.dart';

class NavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubPage Example',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => NavFirstPage(),
        '/second': (context) => NavSecondPage(),
      },
    );
  }
}

class NavFirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavFirstPage();
}

class _NavFirstPage extends State<NavFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sub Page Main')),
      body: Container(
        child: Center(
          child: Text('First Page')
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/second');
        },
        child: Icon(Icons.add)
      ),
    );
  }
}

class NavSecondPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Page')),
      body: Container(
          child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Back')
              )
          )
      ),
    );
  }
}
