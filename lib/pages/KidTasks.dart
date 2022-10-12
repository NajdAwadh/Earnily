import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:earnily/api/taskApi.dart';
import 'package:earnily/api/kidtaskApi.dart';
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
        Provider.of<TaskNotifier>(context);
    getTask(taskNotifier);
    super.initState();
  }

  String state = "";
  bool click = true;

  Future updateTask(String taskID) async {
    await FirebaseFirestore.instance
        .collection('Task')
        .doc(taskID)
        .update({'sate': 'pending'});
  }

  void _showDialog(String taskID) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              " !تم إرسال الطلب لوالدك",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            content: Text(
              "عند الموافقة ستضاقف النقاط إلى حسابك",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  //Navigator.of(context).pop();
                  setState(() {
                    click = false;
                  });
                  updateTask(taskID);
                  _updateState(context);
                },
                child: const Text(
                  "حسناً",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text(
                  "لم أكمل مهمتي بعد",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  void _updateState(BuildContext context) {
    Navigator.of(context).pop();
    //updateTask();
  }

  @override
  Widget build(BuildContext context) {
    TaskNotifier taskNotifier = Provider.of<TaskNotifier>(context);
    click = true;

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
      body: taskNotifier.taskList.isEmpty
          ? Center(
              child: Text(
                "لا يوجد لديك مهام",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )
          : Container(
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
                          ' ${taskNotifier.taskList[index].date}                                                                                   النقاط : ${taskNotifier.taskList[index].points}',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: Icon(
                            //(click == true)
                            //?
                            Icons.check_box,
                          ),
                          //: Icons.lock_clock),
                          //color: Theme.of(context).errorColor,
                          onPressed: () => {
                            Icon(Icons.lock_clock),
                            _showDialog(
                                '${taskNotifier.taskList[index].taskName}'),
                            // showDialog(
                            //     context: context,
                            //     builder: (context) => AlertDialog(
                            //           title: Text('!تم إرسال الطلب لوالدك'),
                            //           content: Text(
                            //               'عندالموافقة ستضاقف النقاط إالى حسابك'),
                            //           actions: [
                            //             TextButton(
                            //                 onPressed: () => Navigator.pop(context),
                            //                 child: Text('لم أكمل مهمتي بعد')),
                            //             TextButton(
                            //                 onPressed: () =>
                            //                 updateTask(),
                            //                 child: Text('حسنا'))
                            //           ],
                            //         ))
                          },
                          //),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: taskNotifier.taskList.length,
              ),
            ),
    );

    // SingleChildScrollView(
    //   child: Column(
    //     // mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: <Widget>[
    //       TaskList(_userTasks, _deleteTask),
    //     ],
    //   ),
    // ),

    //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    //home: MyHomePage(),
  }
}
