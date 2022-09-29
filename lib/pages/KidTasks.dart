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
      //body: Center(
      //child: Text('لاتوجد أنشطة مضافة'),

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
    );
  }
}
