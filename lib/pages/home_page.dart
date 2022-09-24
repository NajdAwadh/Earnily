import 'dart:math';

import 'package:earnily/addKids/addkids_screen_1.dart';
import 'package:earnily/addKids/adultKids.dart';
import 'package:earnily/screen/qrCreateScreen.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:earnily/widgets/MainTask.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../reuasblewidgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: imgWidget(
              "/Users/najdalm/Desktop/Earnily/assets/images/EarnilyLogo.png",
              50,
              250),
        ),
        actions: [
          IconButton(
            onPressed: () {
// do something  Navigator.of(context).push(
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const QrCreateScreen('اضافة بالغ');
                  },
                ),
              );
            },
            icon: Icon(Icons.share),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(children: [
            DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  imgWidget("assets/images/mylogo.png", 200, 100),
                    Text('صفحتي الشخصية',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    Text('_________________________________',
                        style: TextStyle(color: Colors.white)),
                    Text(user.email! + ' :الايميل',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      color: Colors.white,
                      child:
                          Text(' تسجيل خروج', style: TextStyle(fontSize: 19)),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          print(index);
        },
        items: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const AdultKids();
                  },
                ),
              );
            },
            icon: Icon(
              Icons.child_care,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            onPressed: () {
              /*  Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MainTask();
                  },
                ),
              );*/

              Text('task');
            },
            icon: Icon(
              Icons.task,
              color: Colors.white,
              size: 35,
            ),
          ),
          Icon(
            Icons.star,
            color: Colors.white,
            size: 35,
          ),
        ],
      ),
    );
  }
}
