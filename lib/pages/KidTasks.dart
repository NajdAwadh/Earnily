import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:earnily/api/taskApi.dart';
import 'package:earnily/api/kidtaskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:earnily/models/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:earnily/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/kids.dart';
import '../notifications/notification_api.dart';
import '../notifier/kidsNotifier.dart';
import '../reuasblewidgets.dart';
import 'package:http/http.dart' as http;

class kidTasks extends StatefulWidget {
  const kidTasks({Key? key}) : super(key: key);

  @override
  State<kidTasks> createState() => _kidTasksState();
}

int points = 0;

class _kidTasksState extends State<kidTasks> {
  //notification
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final user = FirebaseAuth.instance.currentUser!;
  List _selecteCategorysID = [];
  String? mtoken = " ";
  @override
  void initState() {
    super.initState();
    _getUserDetail();
    requestPermission();

    // getToken();
  }

  void sendPushMessage() async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAA5eBmZts:APA91bFUp8EYFt--BGdxV7o4PjaZuLtgso883qpbr5Cn7reyqaekt7g1PKdrzKID3JgU33Tl9rrf40TvF-il14Q_0hXknWATm6Q6D8jyQu6LUbvb8DrSMscy7HKIRM9LwF1oZJVek391',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Test Body',
              'title': 'Test Title 2'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "/topics/Animal",
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }

  /*void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token;
        print('my token is $mtoken');
      });
      saveToken(token!);
    });
  }*/

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('wBFhZAKFBjTsuQ5b3KQtUl0oWl32')
        .set({
      'token': token,
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );
    }
  }

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

  void _onCategorySelected(bool selected, String tid) {
    if (selected == true) {
      showToastMessage('تم التآكيد! انتظر قبول والدك');

      setState(() {
        _selecteCategorysID.add(tid);
      });
    } else {
      setState(() {
        _selecteCategorysID.add(tid);
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
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('kids')
        .doc(user.email)
        .collection('Task')
        .orderBy('date')
        .snapshots();

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
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            return new Directionality(
              textDirection: ui.TextDirection.rtl,
              child: !snapshot.hasData
                  ? Center(
                      child: Text(
                        'لايوجد مهام',
                        style: TextStyle(fontSize: 30, color: Colors.grey),
                      ),
                    )
                  : Container(
                      child: GridView.builder(
                        itemBuilder: (ctx, index) {
                          Map<String, dynamic> document =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                          String iconData = '';
                          Color iconColor;
                          switch (document['category']) {
                            case "النظافة":
                              // iconData = Icons.wash;
                              iconData = '🫧';

                              iconColor = Color(0xffff6d6e);
                              break;
                            case "الأكل":
                              // iconData = Icons.flatware_rounded;
                              iconData = '🍽';
                              iconColor = Color(0xfff29732);
                              break;

                            case "الدراسة":
                              // iconData = Icons.auto_stories_outlined;
                              iconData = '📚';
                              iconColor = Color(0xff6557ff);
                              break;

                            case "تطوير الشخصية":
                              //  iconData = Icons.border_color_outlined;
                              iconData = '📖';
                              iconColor = Color(0xff2bc8d9);
                              break;

                            case "الدين":
                              //  iconData = Icons.brightness_4_rounded;
                              iconData = '🕌';
                              iconColor = Color(0xff234ebd);
                              break;
                            default:
                              // iconData = Icons.brightness_4_rounded;
                              iconColor = Color(0xff6557ff);
                          }
                          return Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: Container(
                                height: 150,
                                color:
                                    iconColor, //Colors.primaries[Random().nextInt(myColors.length)],

                                child: new Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: new GridTile(
                                    child: Column(
                                      children: [
                                        // SizedBox(height: 1),
                                        //    imgWidget(set(list[index].gender), 64, 64),

                                        //SizedBox(height: 1),
                                        SizedBox(height: 35),
                                        /*  Container(
                                        height: 33,
                                        width: 36,
                                        child: Icon(iconData),
                                      ),*/
                                        Text(
                                          iconData + document['taskName'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          '🕐' + document['date'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          '🌟' + document['points'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        if (document['state'] == "Not complete")
                                          Padding(
                                            padding: EdgeInsets.all(0),
                                            child: CheckboxListTile(
                                              selected: false,
                                              value: _selecteCategorysID
                                                  .contains(document['tid']),
                                              onChanged: (selected) {
                                                print(document['state']);
                                                print(document);
                                                updateTask(document['tid'],
                                                    document['adult']);

                                                _onCategorySelected(
                                                    selected!, document['tid']);
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                      ),
                    ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 150,
        height: 60,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: SizedBox(
          child: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.wallet,
              size: 30,
            ),
            onPressed: () {
              //
            },
            label: Text(
              points.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getUserDetail() {
    FirebaseFirestore.instance
        .collection('kids')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      points = snapshot.get("points");
      //rid = snapshot.get("rid");
      setState(() {});
    });
  }
}
