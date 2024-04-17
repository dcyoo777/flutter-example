import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'largeFileMain.dart';

class LogoMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LogoMainPage();
}

class _LogoMainPage extends State<LogoMainPage> {
  final imgUrl =
      'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress';

  bool downloading = false;
  var progressString = '';
  String file = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Text('Change logo'),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LargeFileMain()));
                    },
                    child: Text(
                        'Change logo',
                        style: TextStyle(color: Colors.black)
                    )
                )
              ]
          ),
          body: Container()
    );
  }

}
