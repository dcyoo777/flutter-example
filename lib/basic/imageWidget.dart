import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageWidgetApp();
  }
}

class _ImageWidgetApp extends State<ImageWidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Material Design App", style: TextStyle(color: Colors.white)), backgroundColor: Colors.blue,),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/sample.jpg', width: 100, height: 200),
              Text(
                  'Hello Flutter',
                  style: TextStyle(
                    fontFamily: 'Pretendard',
                    fontSize: 30,
                    color: Colors.blue,
                  ))
            ]
          )
        )
      )
    );
  }
}
