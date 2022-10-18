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
  Future getPointsFirestore() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("points").get();
    return qn.docs;
  }

  //snapShot.data[index]
  void initState() {
    // TODO: implement initState
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    getTask(taskNotifier);
    super.initState();
  }

  Future updateTask(String id, String adult, kid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(adult)
        .collection("Task")
        .doc(id)
        .delete();
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(kid + '@gmail.com')
        .collection("Task")
        .doc(id)
        .update({'state': 'complete'});
  }

  Future delete(String id, String adult, kid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(adult)
        .collection("Task")
        .doc(id)
        .delete();
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(kid + '@gmail.com')
        .collection("Task")
        .doc(id)
        .delete();
  }

  void _showDialog(String id, String adult, String kid) {
    showDialog(
        context: context,
        builder: (context) {
          // set up the buttons
          Widget cancelButton = TextButton(
            child: Text(
              "رفض",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            onPressed: () {
              // Navigator.of(context).pop;
              delete(id, adult, kid);
            },
          );
          Widget continueButton = TextButton(
            child: Text(
              "قبول",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            onPressed: () {
              // Navigator.of(context).pop;
              updateTask(id, adult, kid);
            },
          );
          return AlertDialog(
            title: Text(
              'قبول اتمام المهمة',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            content: Text(
              'هل انت متاكد بقبول مهمة طفلك؟',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              cancelButton,
              continueButton,
            ],
          );
        });
  }

  void _showDialog2() {
    showDialog(
        context: context,
        builder: (context) {
          // set up the buttons
          Widget cancelButton = TextButton(
            child: Text(
              "حسنا",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: Navigator.of(context).pop,
          );

          return AlertDialog(
            title: Text(
              'طفلك لم يكمل المهمة بعد',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            actions: [
              cancelButton,
            ],
          );
        });
  }

  String _colors(String i) {
    if (i == "Not complete") {
      return 'غير مكتمل';
    } else if (i == "pending")
      return 'انتظار موافقتك';
    else
      return 'مكتمل';
  }

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            'الانشطة الحالية',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),

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
                              '   ${taskNotifier.taskList[index].asignedKid} \n 🌟 ${taskNotifier.taskList[index].points} | ${_colors(taskNotifier.taskList[index].state)}',
                              style: TextStyle(fontSize: 17),
                            ),
                            isThreeLine: true,
                            trailing: Wrap(spacing: 0, children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.delete),
                                color: Theme.of(context).errorColor,
                                onPressed: () => {
                                  //delete
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.pending_actions),
                                color: Colors.black,
                                onPressed: () => {
                                  if (taskNotifier.taskList[index].state ==
                                      'pending')
                                    _showDialog(
                                        taskNotifier.taskList[index].tid,
                                        taskNotifier.taskList[index].adult,
                                        taskNotifier.taskList[index].asignedKid)
                                  else
                                    _showDialog2()
                                },
                              ),
                            ])),
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

      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,

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
