import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:earnily/api/taskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainTask extends StatefulWidget {
  const MainTask({super.key});

  @override
  State<MainTask> createState() => _MainTaskState();
}

class _MainTaskState extends State<MainTask> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("task").snapshots();
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

      body: taskNotifier.taskList.isEmpty
          ? Center(
              child: Text(
                "لا يوجد لديك مهام \n قم بالإضافة الآن",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  IconData iconData;
                  Color iconColor;
                  switch (taskNotifier.taskList[index].category) {
                    case "النظافة":
                      iconData = Icons.wash;

                      iconColor = Color(0xffff6d6e);
                      break;
                    case "الأكل":
                      iconData = Icons.flatware_rounded;
                      iconColor = Color(0xfff29732);
                      break;

                    case "الدراسة":
                      iconData = Icons.auto_stories_outlined;
                      iconColor = Color(0xff6557ff);
                      break;

                    case "تطوير الشخصية":
                      iconData = Icons.border_color_outlined;
                      iconColor = Color(0xff2bc8d9);
                      break;

                    case "الدين":
                      iconData = Icons.brightness_4_rounded;
                      iconColor = Color(0xff234ebd);
                      break;
                    default:
                      iconData = Icons.brightness_4_rounded;
                      iconColor = Color(0xff6557ff);
                  }
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
                            backgroundColor: iconColor,
                            foregroundColor: Colors.white,
                            radius: 30,
                            child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  height: 33,
                                  width: 36,
                                  child: Icon(iconData),
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
                            ' اسم الطفل:  ${taskNotifier.taskList[index].asignedKid} \n 🌟 ${taskNotifier.taskList[index].points}',
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
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
