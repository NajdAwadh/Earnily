import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:earnily/api/taskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:earnily/widgets/view_task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../notifications/notification_api.dart';

class StreamTask extends StatefulWidget {
  const StreamTask({super.key});

  @override
  State<StreamTask> createState() => _StreamTaskState();
}

class _StreamTaskState extends State<StreamTask> {
  final usserr = FirebaseAuth.instance.currentUser!;

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('users')
      .doc('u2ugWimG5NVtLFAloARuIIT5I5y1')
      .collection('Task')
      .snapshots();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            'انشطة اطفالي ',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            return ListView.builder(
              
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> document = snapshot.data!.docs[index].data() as Map<String, dynamic> ;
                  IconData iconData;
                                              Color iconColor;
                                              switch ('النظافة') {
                                                case "النظافة":
                                                  iconData = Icons.wash;

                                                  iconColor = Color(0xffff6d6e);
                                                  break;
                                                case "الأكل":
                                                  iconData =
                                                      Icons.flatware_rounded;
                                                  iconColor = Color(0xfff29732);
                                                  break;

                                                case "الدراسة":
                                                  iconData = Icons
                                                      .auto_stories_outlined;
                                                  iconColor = Color(0xff6557ff);
                                                  break;

                                                case "تطوير الشخصية":
                                                  iconData = Icons
                                                      .border_color_outlined;
                                                  iconColor = Color(0xff2bc8d9);
                                                  break;

                                                case "الدين":
                                                  iconData = Icons
                                                      .brightness_4_rounded;
                                                  iconColor = Color(0xff234ebd);
                                                  break;
                                                default:
                                                  iconData = Icons
                                                      .brightness_4_rounded;
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
                            document['taskName'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            'k',
                            style: TextStyle(fontSize: 17),
                          ),
                          isThreeLine: true,
                        ),
                      ));
                });
          }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
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
    );
  }
}
