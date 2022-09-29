/*
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:earnily/api/taskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class kidTasks extends StatefulWidget {
  const kidTasks({super.key});

  @override
  State<kidTasks> createState() => _kidTasksState();
}

class _kidTasksState extends State<kidTasks> {
  void initState() {
    // TODO: implement initState
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    getTask(taskNotifier);
    super.initState();
  }

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
            "مهامي",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      // body: Center(
      //   child: Text('لاتوجد أنشطة مضافة'),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () {
      //     //do something
      //   },
      //   child: Icon(
      //     Icons.add,
      //     size: 30,
      //   ),
      // ),

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
                      taskNotifier.taskList[index].taskName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    subtitle: Text(
                      ' اسم الطفل:  ${taskNotifier.taskList[index].asignedKid}                                                                                   النقاط : ${taskNotifier.taskList[index].points}',
                    ),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(Icons.check_box),
                      color: Theme.of(context).errorColor,
                      onPressed: () => {},
                    ),
                  ),
                ));
          },
          itemCount: taskNotifier.taskList.length,
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
    );
  }
}*/

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:earnily/api/taskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class kidTasks extends StatefulWidget {
  const kidTasks({super.key});

  @override
  State<kidTasks> createState() => _kidTasksState();
}

class _kidTasksState extends State<kidTasks> {
  void initState() {
    // TODO: implement initState
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    getTask(taskNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'الانشطة الحالية',
          style: TextStyle(fontSize: 40),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of (context) .size.width,
      //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      //     child: Column(
      //       children: [ adultTaskCard(
// title: "Wake up ",
// check: true,
// iconBColor: Colors.white,
// iconcolor: Colors.red,
// iconData: Icons.alarm,
// time: "10 AM",
//  ), // Todocard
// SizedBox ( height: 10, ), ]// sizedBox
// ),),),
// // Column
// // Container
// // singlechildscrollview

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
                      taskNotifier.taskList[index].taskName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    // subtitle: Text(
                    //   ' اسم الطفل:  ${taskNotifier.taskList[index].asignedKid}                                                                                   النقاط : ${taskNotifier.taskList[index].points}',
                    // ),
                    // isThreeLine: true,
                    trailing: IconButton(
                      icon: Icon(Icons.check_box),
                      color: Theme.of(context).errorColor,
                      onPressed: () => {},
                    ),
                  ),
                ));
          },
          itemCount: taskNotifier.taskList.length,
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

      //home: MyHomePage(),
    );
  }
}
