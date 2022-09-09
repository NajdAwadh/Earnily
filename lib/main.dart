import 'package:flutter/material.dart';
import 'package:flutterapp/earnilyapp/generatedtasklistwidget/GeneratedTasklistWidget.dart';
import 'package:flutterapp/earnilyapp/generatediconaddcirclewidget/GeneratediconaddcircleWidget.dart';
import 'package:flutterapp/earnilyapp/generatedaddtaskwidget/GeneratedAddtaskWidget.dart';
import 'package:flutterapp/earnilyapp/generatediconaddcirclewidget1/GeneratediconaddcircleWidget1.dart';

void main() {
  runApp(EarnilyApp());
}

class EarnilyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/GeneratedTasklistWidget',
      routes: {
        '/GeneratedTasklistWidget': (context) => GeneratedTasklistWidget(),
        '/GeneratediconaddcircleWidget': (context) =>
            GeneratediconaddcircleWidget(),
        '/GeneratedAddtaskWidget': (context) => GeneratedAddtaskWidget(),
        '/GeneratediconaddcircleWidget1': (context) =>
            GeneratediconaddcircleWidget1(),
      },
    );
  }
}
