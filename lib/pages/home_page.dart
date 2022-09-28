import 'dart:math';

import 'package:earnily/Rewards/MainRewards.dart';
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
  int _selectedIndex = 0;

  void _navigationBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    AdultKids(),
    MainTask(),
    MainRewards(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.qr_code_scanner_sharp,
          size: 30,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: imgWidget(
              "/Users/najdalm/Desktop/Earnily/assets/images/EarnilyLogo.png",
              50,
              250),
        ),
        /* actions: [
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
            icon: Icon(Icons.menu),
          ),
        ],*/
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(children: [
            DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  imgWidget("assets/images/mylogo.png", 200, 100),

                    imgWidget(
                        "/Users/najdalm/Desktop/Earnily/assets/images/EarnilyLogo.png",
                        100,
                        250),

                    ListTile(
                      title: Text(
                        textAlign: TextAlign.right,
                        'الصفحة الرئيسية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      trailing: Icon(
                        Icons.home_filled,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const HomePage();
                            },
                          ),
                        );
                      },
                    ),

                    ListTile(
                      title: Text(
                        textAlign: TextAlign.right,
                        'ملفي الشخصي',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      trailing: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        //do
                      },
                    ),

                    ListTile(
                      title: Text(
                        textAlign: TextAlign.right,
                        'الاعدادات والخصوصية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      trailing: Icon(
                        Icons.settings_suggest_sharp,
                        color: Colors.white,
                        size: 30,
                      ),
                      onTap: () {
                        //do
                      },
                    ),

                    /*  MaterialButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const SignInScreen();
                            },
                          ),
                        );
                      },
                      color: Colors.white,
                      child:
                          Text(' تسجيل خروج', style: TextStyle(fontSize: 19)),
                    ),*/
                  ]),
            ),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        onTap: _navigationBar,
        items: [
          Icon(
            Icons.child_care,
            color: Colors.white,
            size: 35,
          ),
          Icon(
            Icons.task,
            color: Colors.white,
            size: 35,
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
