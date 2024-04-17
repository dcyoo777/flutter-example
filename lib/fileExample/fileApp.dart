import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  int _count = 0;
  List<String> itemList = new List.empty(growable: true);
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    readCountFile();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  Future<List<String>> readListFile() async {
    List<String> itemList = new List.empty(growable: true);
    var key = 'fruit';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path + '/fruit.txt').exists();

    String file;

    if (firstCheck == null || firstCheck == false || fileExist == false) {
      pref.setBool(key, true);
      file = await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + 'fruit.txt').writeAsStringSync(file);
    } else {
      file = await File(dir.path + '/fruit.txt').readAsString();
    }

    var array = file.split('\n');

    for (var item in array) {
      print(item);
      if (item.isNotEmpty) {
        itemList.add(item);
      }
    }
    print(itemList);
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'dsf',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('File Example')),
            body: Container(
              child: Center(
                  child: Column(
                children: <Widget>[
                  TextField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                  ),
                  Expanded(
                      child: ListView.builder(itemCount: itemList.length, itemBuilder: (context, index) {
                    return Card(
                        child: Center(
                            child: Text(itemList[index],
                                style: TextStyle(fontSize: 30))));
                  }
                  ))
                ],
              )),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  writeFruit(controller.value.text);
                  setState(() {
                    itemList.add(controller.value.text);
                  });
                  controller.clear();
                },
                child: Icon(Icons.add))));
  }

  void writeFruit(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/fruit.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + 'fruit.txt').writeAsStringSync(file);
  }

  void writeCountFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

  void readCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
