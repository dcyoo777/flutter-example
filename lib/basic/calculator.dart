import 'package:flutter/material.dart';

class CalculatorWidgetApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalculatorWidgetApp();
  }
}

class _CalculatorWidgetApp extends State<CalculatorWidgetApp> {
  List _buttonList = ['Add', 'Minus', 'Multiply', 'Divide'];
  List<DropdownMenuItem<String>> _dropDownMenuItems =
      new List.empty(growable: true);
  String? _buttonText;

  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Material Design App",
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Container(
            child: Center(
                child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text('결과 : $sum', style: const TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                keyboardType: TextInputType.number, controller: value1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                keyboardType: TextInputType.number, controller: value2),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
              child: Row(children: <Widget>[const Icon(Icons.add), Text(_buttonText!)]),
              onPressed: () {
                setState(() {
                  var value1Int = double.parse(value1.value.text);
                  var value2Int = double.parse(value2.value.text);
                  var result;

                  if (_buttonText == _buttonList[0]) {
                    result = value1Int + value2Int;
                  } else if (_buttonText == _buttonList[1]) {
                    result = value1Int - value2Int;
                  } else if (_buttonText == _buttonList[2]) {
                    result = value1Int * value2Int;
                  } else if (_buttonText == _buttonList[3]) {
                    result = value1Int / value2Int;
                  }
                  sum = '$result';
                });
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButton(
                items: _dropDownMenuItems,
                onChanged: (String? value) {
                  setState(() {
                    _buttonText = value;
                  });
                },
                value: _buttonText,
              )
          ),
        ]))));
  }
}
