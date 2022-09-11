import 'package:flutter/material.dart';

//void main() {
//runApp(MyApp());
//}

class task {
  String taskName;
  String childName;
  String category;
  int points;
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int i = 0;
  void AnswerQuestion() {
    setState(() {
      i++;
    });

    print(i);
  }

  @override
  Widget build(BuildContext context) {
    var Qa = ['qa1', 'qa2'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('إضافة مهمة'),
        ),
        body: Column(
          children: [
            Text(Qa[i]),
            ElevatedButton(
              child: Text('answer1'),
              onPressed: AnswerQuestion,
            ),
            ElevatedButton(
              child: Text('answer2'),
              onPressed: AnswerQuestion,
            ),
            ElevatedButton(
              child: Text('answer3'),
              onPressed: AnswerQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
