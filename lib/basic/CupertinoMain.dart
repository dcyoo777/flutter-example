import 'package:flutter/cupertino.dart';
import '../animalItem.dart';
import '../iosSub/cupertinoFirstPage.dart';
import '../iosSub/cupertinoSecondPage.dart';

class CupertinoMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CupertinoMain();
  }
}

class _CupertinoMain extends State<CupertinoMain> {
  CupertinoTabBar? tabBar;
  List<Animal> animalList = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabBar = CupertinoTabBar(items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ]);
    animalList.add(Animal(animalName: '벌', kind: '곤충', imagePath: 'image/bee.png'));
    animalList.add(Animal(animalName: '고양이', kind: '포유류', imagePath: 'image/cat.png'));
    animalList.add(Animal(animalName: '젖소', kind: '포유류', imagePath: 'image/cow.png'));
    animalList.add(Animal(animalName: '강아지', kind: '포유류', imagePath: 'image/dog.png'));
    animalList.add(Animal(animalName: '여우', kind: '포유류', imagePath: 'image/fox.png'));
    animalList.add(Animal(animalName: '원숭이', kind: '영장류', imagePath: 'image/monkey.png'));
    animalList.add(Animal(animalName: '돼지', kind: '포유류', imagePath: 'image/pig.png'));
    animalList.add(Animal(animalName: '늑대', kind: '포유류', imagePath: 'image/wolf.png'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        home: CupertinoTabScaffold(
            tabBar: tabBar!,
            tabBuilder: (context, value) {
              if (value == 0) {
                return CupertinoFirstPage(
                  animalList: animalList,
                );
              } else {
                return CupertinoSecondPage(
                  animalList: animalList,
                );
              }
            }));
  }
}
