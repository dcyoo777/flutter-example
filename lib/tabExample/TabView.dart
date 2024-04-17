import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/tabExample/firstPage.dart';
import 'package:my_app/tabExample/secondPage.dart';

import '../animalItem.dart';

class MyTabView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyTabView();
  }
}


class _MyTabView extends State<MyTabView> with SingleTickerProviderStateMixin {

  TabController? controller;
  List<Animal> animalList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(animalName: "벌", kind: "곤충", imagePath: "image/bee.png"));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "image/cat.png"));
    animalList.add(Animal(animalName: "젖소", kind: "포유류", imagePath: "image/cow.png"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "image/dog.png"));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "image/fox.png"));
    animalList.add(Animal(animalName: "원숭이", kind: "영장류", imagePath: "image/monkey.png"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "image/pig.png"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류", imagePath: "image/wolf.png"));
  }

  @override build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          FirstPage(list: animalList),
          SecondPage(list: animalList),
        ],
      ),
      bottomNavigationBar: TabBar(
        tabs: <Tab>[
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue)),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue)),
        ],
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
}
