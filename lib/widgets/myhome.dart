import 'package:flutter/material.dart';

import 'new_task.dart';
import 'task_list.dart';

import 'package:earnily/models/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Task> _userTasks = [];

  List<Task> get _recentTask {
    return _userTasks.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTask(String txTitle, String TxKid, String TxCategory,
      double txAmount, DateTime chosenDate) {
    final newTx = Task(
      title: txTitle,
      kid: TxKid,
      category: TxCategory,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTasks.add(newTx);
    });
    Future addTask() async {
      await FirebaseFirestore.instance.collection('tasks').add({
        'title': txTitle,
        'kid': TxKid,
        'category': TxCategory,
        'amount': txAmount,
        'date': chosenDate,
        'id': DateTime.now().toString(),
      });
    }
  }

  void _startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTask(_addNewTask),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTask(String id) {
    setState(() {
      _userTasks.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          'الانشطة الحالية',
          style: TextStyle(fontSize: 40),
        ),
        actions: [
          IconButton(
            onPressed: () {
// do something
            },
            icon: Icon(Icons.share),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TaskList(_userTasks, _deleteTask),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTask(context),
      ),
    );
  }
}
