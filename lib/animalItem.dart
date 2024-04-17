import 'package:flutter/material.dart';

class Animal {
  String? imagePath;
  String? animalName;
  String? kind;
  bool? flyExist = false;

  Animal ({
    required this.animalName,
    required this.kind,
    required this.imagePath,
    this.flyExist
  });
}

// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Center(
//           child: Text('First Page')
//         )
//       )
//     );
//   }
// }

