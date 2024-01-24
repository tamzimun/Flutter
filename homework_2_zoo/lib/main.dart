import 'package:flutter/material.dart';
import 'animal_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Виртуальный Зоопарк',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimalList(),
    );
  }
}