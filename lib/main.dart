import 'package:animation/screen/one_page.dart';
import 'package:flutter/material.dart';

import 'screen/list_screeen.dart';
import 'screen/one_page2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter animation',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const OnePage2(),
    );
  }
}
