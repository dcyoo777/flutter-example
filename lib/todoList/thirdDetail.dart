import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final String args = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page')
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(args, style: TextStyle(fontSize: 30)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Back to First Page')
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        )
      )
    );
  }
}
