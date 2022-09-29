import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class kidTasks extends StatefulWidget {
  const kidTasks({super.key});

  @override
  State<kidTasks> createState() => _kidTasksState();
}

class _kidTasksState extends State<kidTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "انشطتي",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Center(
        child: Text('لاتوجد أنشطة مضافة'),
      ),
    );
  }
}
