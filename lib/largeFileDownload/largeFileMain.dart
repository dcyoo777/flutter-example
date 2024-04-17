import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LargeFileMain();
}

class _LargeFileMain extends State<LargeFileMain> {
  final imgUrl =
      'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress';

  bool downloading = false;
  var progressString = '';
  String file = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Large File Example')),
      body: downloading
          ? Container(
              height: 120.0,
              // width: 200.0,
              child: Center(
                  child: Card(
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text('Downloading File: $progressString',
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ))))
          : FutureBuilder(
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    print('none');
                    return Text('No Data');
                  case ConnectionState.waiting:
                    print('waiting');
                    return CircularProgressIndicator();
                  case ConnectionState.active:
                    print('active');
                    return CircularProgressIndicator();
                  case ConnectionState.done:
                    print('done');
                    if (snapshot.hasData) {
                      return snapshot.data as Widget;
                    }
                }
                print('end process');
                return Text('No Data');
              },
              future: downloadWidget(file)),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            downloadFile();
          },
          child: Icon(Icons.file_download)),
    );
  }

  Future<Widget> downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();

    if (exist) {
      return Center(
          child: Column(children: <Widget>[Image.file(File(filePath))]));
    } else {
      return Text('No Data');
    }
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(imgUrl, '${dir.path}/myimage.jpg',
          onReceiveProgress: (res, total) {
        print('Rec: $res, Total: $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = '${((res / total) * 100).toStringAsFixed(0)}%';
        });
      });
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      downloading = false;
      progressString = 'Completed!';
    });
    print('Download completed!');
  }
}
