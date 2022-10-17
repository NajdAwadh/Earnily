import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:earnily/api/taskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:provider/provider.dart';
import 'package:earnily/widgets/view_task.dart';
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

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
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
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text(
                  "قبول",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          );
        });
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
                            '   ${taskNotifier.taskList[index].asignedKid} \n 🌟 ${taskNotifier.taskList[index].points}',
                            style: TextStyle(fontSize: 20),
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => {
                              _showDialog(),
                            },
                          ),
                          onTap: () {
                            taskNotifier.currentTask =
                                taskNotifier.taskList[index];
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return View_task();
                            }));
                          },
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
