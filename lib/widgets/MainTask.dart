import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:flutter/material.dart';

import 'new_task.dart';
import 'task_list.dart';
import 'package:earnily/models/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'myhome.dart';

class MainTask extends StatefulWidget {
  const MainTask({super.key});

  @override
  State<MainTask> createState() => _MainTaskState();
}

class _MainTaskState extends State<MainTask> {
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

  void _deleteTask(String id) {
    setState(() {
      _userTasks.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'الانشطة الحالية',
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) {
            return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: new Directionality(
                  textDirection: TextDirection.rtl,
                  child: new ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xffff6d6e),
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            height: 33,
                            width: 36,
                            child: Icon(Icons.wash),
                          )),
                    ),
                    title: Text(
                      "اسم النشاط",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    subtitle: Text(
                      ' ريما  -   60',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => {},
                    ),
                  ),
                ));
          },
          itemCount: 1,
        ),
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     // mainAxisAlignment: MainAxisAlignment.start,
      //     crossAxisAlignment: CrossAxisAlignment.stretch,
      //     children: <Widget>[
      //       TaskList(_userTasks, _deleteTask),
      //     ],
      //   ),
      // ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const Add_task();
              },
            ),
          );
        },
      ),

      //home: MyHomePage(),
    );
  }
}
