import 'package:flutter/cupertino.dart';
import '../animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal> animalList;
  const CupertinoSecondPage({Key? key, required this.animalList})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CupertinoSecondPage();
  }
}


class _CupertinoSecondPage extends State<CupertinoSecondPage> {

  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _flyExist = false;
  String? _imagePath;
  Map<int, Widget> segmentWidgets = {
    0: SizedBox(
      child: Text('양서류', textAlign: TextAlign.center),
    ),
    1: SizedBox(
      child: Text('포유류', textAlign: TextAlign.center),
    ),
    2: SizedBox(
      child: Text('파충류', textAlign: TextAlign.center),
    ),
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Add Animal")),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: CupertinoTextField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                )
              ),
              CupertinoSegmentedControl(
                padding: EdgeInsets.only(bottom: 20, top: 20),
                groupValue: _kindChoice,
                children: segmentWidgets,
                onValueChanged: (int value) {
                  setState(() {
                    _kindChoice = value;
                  });
                },
              ),
              Row(
                children: <Widget>[
                  Text("날개가 있습니까?"),
                  CupertinoSwitch(
                    value: _flyExist,
                    onChanged: (value) {
                      setState(() {
                        _flyExist = value;
                      });
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      child: Image.asset('image/cow.png', width: 80),
                      onTap: () { _imagePath = 'image/cow.png'; }
                    ),
                    GestureDetector(
                      child: Image.asset('image/pig.png', width: 80),
                      onTap: () { _imagePath = 'image/pig.png'; }
                    ),
                    GestureDetector(
                      child: Image.asset('image/bee.png', width: 80),
                      onTap: () { _imagePath = 'image/bee.png'; }
                    ),
                    GestureDetector(
                      child: Image.asset('image/cat.png', width: 80),
                      onTap: () { _imagePath = 'image/cat.png'; }
                    ),
                    GestureDetector(
                      child: Image.asset('image/fox.png', width: 80),
                      onTap: () { _imagePath = 'image/fox.png'; }
                    ),
                    GestureDetector(
                      child: Image.asset('image/monkey.png', width: 80),
                      onTap: () { _imagePath = 'image/monkey.png'; }
                    ),
                  ]
                )
              ),
              CupertinoButton(
                child: Text("Add Animal"),
                onPressed: () {
                  widget.animalList?.add(Animal(
                    animalName: _textController?.value.text,
                    kind: getKind(_kindChoice),
                    imagePath: _imagePath,
                    flyExist: _flyExist,
                  ));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        )
      )
    );
  }

  getKind(int radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }

}
