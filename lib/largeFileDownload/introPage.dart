import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_app/largeFileDownload/introPAge.dart';
import 'package:path_provider/path_provider.dart';

import 'logo.dart';

class IntroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  Widget logo = Icon(
    Icons.info,
    size: 50,
  );

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        logo,
        Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return LogoMainPage();
                  }));
                },
                child: Text('다음으로 가기')))
      ],
    ))));
  }

  void initData() async {
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/myimage.jpg').exists();
    if (fileExist) {
      setState(() {
        logo = Image.file(
          File(dir.path + '/myimage.jpg'),
          height: 200,
          width: 200,
          fit: BoxFit.fill,
        );
      });
    }
  }
}
