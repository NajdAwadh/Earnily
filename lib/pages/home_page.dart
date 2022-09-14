import 'dart:math';

import 'package:earnily/addKids/addkids_screen_1.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          '! أهـلا بـك',
          style: TextStyle(fontSize: 40),
        ),
        actions: [
          IconButton(
            onPressed: () {
// do something
            },
            icon: Icon(Icons.share),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple,
          child: ListView(children: [
            DrawerHeader(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('E A R N I L Y',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    Text('_________________________________',
                        style: TextStyle(color: Colors.white)),
                    Text(user.email! + ' :الايميل',
                        style: TextStyle(fontSize: 15)),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      color: Colors.white,
                      child: Text('تسجيل خروج', style: TextStyle(fontSize: 20)),
                    ),
                  ]),
            ),
          ]),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.deepPurple,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          print(index);
        },
        items: [
          Icon(
            Icons.home,
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
            color: Colors.yellow[500],
            size: 35,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const AddKids_screen_1();
              },
            ),
          );
        },
      ),
    );
  }
}
