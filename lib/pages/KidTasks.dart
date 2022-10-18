import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:earnily/api/taskApi.dart';
import 'package:earnily/api/kidtaskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:earnily/models/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/kids.dart';
import '../notifier/kidsNotifier.dart';
import '../reuasblewidgets.dart';

class kidTasks extends StatefulWidget {
  const kidTasks({super.key});

  @override
  State<kidTasks> createState() => _kidTasksState();
}

class _kidTasksState extends State<kidTasks> {
  final user = FirebaseAuth.instance.currentUser!;
  final kidsDb = FirebaseFirestore.instance.collection('kids');
  List _selecteCategorysID = [];

  @override
  void initState() {
    // TODO: implement initState
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    getTask(taskNotifier);
    super.initState();
  }

/*
  void profile() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              text,
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("حسناً"),
              )
            ],
          );
        });
  }
*/

  String set(String gender) {
    if (gender == "طفلة")
      return "assets/images/girlIcon.png";
    else
      return "assets/images/boy24.png";
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "حقول الادخال مفقودة",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            content: Text(
              " تأكد من ادخال جميع البيانات من فضلك",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text(
                  "حسناً",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          );
        });
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
        );
  }

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      showToastMessage('تم التآكيد! انتظر قبول والدك');

      setState(() {
        _selecteCategorysID.add(category_id);
      });
    } else {
      setState(() {
        _selecteCategorysID.add(category_id);
      });
    }
  }

  List<Color> myColors = [
    //ghada
    Color(0xffff6d6e),
    Color(0xfff29732),
    Color(0xff6557ff),
    Color(0xff2bc8d9),
    Color(0xff234ebd),

    Color(0xff6DC8F3),
    Color(0xff73A1F9),
    Color(0xffFFB157),
    Color(0xffFFA057),
    Color(0xffFF5B95),
    Color(0xffF8556D),
    Color(0xffD76EF5),
    Color(0xff8F7AFE),
    Color(0xff42E695),
    Color(0xff3BB2B8),
  ];

  Color chooseColor(int index) {
    return myColors[index];
  }

  Future updateTask(String id, String adult) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(adult)
        .collection("Task")
        .doc(id)
        .update({'state': 'pending'});
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(user.email)
        .collection("Task")
        .doc(id)
        .update({'state': 'pending'});
  }

  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);
    var list = taskNotifier.taskList;

    //return Directionality(
    //textDirection: ui.TextDirection.rtl,
    //child:
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Center(
            child: Text(
              "مهامي",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
      body: new Directionality(
        textDirection: ui.TextDirection.rtl,
        child: list.isEmpty
            ? Center(
                child: Text(
                  'لايوجد مهام',
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
              )
            : Container(
                child: GridView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 150,
                          color: chooseColor(
                              index), //Colors.primaries[Random().nextInt(myColors.length)],

                          child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: new GridTile(
                              child: Column(
                                children: [
                                  // SizedBox(height: 1),
                                  //    imgWidget(set(list[index].gender), 64, 64),

                                  CheckboxListTile(
                                    selected: false,
                                    value: _selecteCategorysID
                                        .contains(taskNotifier.taskList[index]),
                                    onChanged: (selected) {
                                      updateTask(
                                          list[index].tid, list[index].adult);
                                      _onCategorySelected(selected!,
                                          taskNotifier.taskList[index]);
                                    },

                                    //   title: Text(taskNotifier.taskList[index]),
                                  ),
                                  //SizedBox(height: 1),
                                  Text(
                                    list[index].taskName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    'أنجز مهمتك قبل: \n' + list[index].date,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    list[index].points,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),

                                  //SizedBox(height: 15),
                                  /*
                                Text(
                                  list[index].date.toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                */
/*
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () => {list[index]},
                                  ),
                                  
*/

                                  /*   IconButton(
                                    icon: Icon(Icons.person),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              //  icon: imgWidget(
                                              //  set(list[index].gender),
                                              //  64,
                                              //  64),
                                              title: Text(
                                                list[index].taskName +
                                                    '\n' +
                                                    list[index].category,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              /* content: Text(
                                                getBirthday(list[index].date)
                                                   .toString(),
                                               textAlign: TextAlign.right,
                                              ),*/
                                              actions: <Widget>[],
                                            );
                                          });
                                    },
                                  ),*/
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                  itemCount: taskNotifier.taskList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                ),
              ),
      ),
    );
  }
}
