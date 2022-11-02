import 'dart:math';
import 'dart:ui' as ui;

import 'package:earnily/addKids/adultsKidProfile.dart';
import 'package:earnily/api/kidsApi.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/kids.dart';
import '../widgets/MainTask.dart';
import 'addkids_screen_1.dart';

import 'package:age_calculator/age_calculator.dart';

class AdultKids extends StatefulWidget {
  const AdultKids({super.key});

  @override
  State<AdultKids> createState() => _AdultKidsState();
}

class _AdultKidsState extends State<AdultKids> {
  final user = FirebaseAuth.instance.currentUser!;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  int getBirthday(Timestamp date) {
    int birth = AgeCalculator.age(date.toDate()).years;
    return birth;
  }

  String set(String gender) {
    if (gender == "طفلة")
      return "assets/images/girlIcon.png";
    else
      return "assets/images/boy24.png";
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

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('kids')
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
              "أطفالي",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
      body: new Directionality(
        textDirection: ui.TextDirection.rtl,
        child: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text(
                  "لا يوجد لديك مهام \n قم بالإضافة الآن",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                );
              }
              return GridView.builder(
                itemBuilder: (contex, index) {
                  Map<String, dynamic> document =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;

                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Container(
                        height: 150,
                        color: chooseColor(index),
                        child: new Directionality(
                          textDirection: TextDirection.rtl,
                          child: new GridTile(
                            child: Column(
                              children: [
                                SizedBox(height: 15),
                                imgWidget(set(document['gender']), 64, 64),
                                Text(
                                  document['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.account_circle_sharp),
                                  color: Colors.black,
                                  iconSize: 40,
                                  onPressed: () {
                                    
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                         
                                                  builder: (builder) => AdultsKidProfile(
                                                                    document:document,
                                                                    id: snapshot.data?.docs[index].id as String
                                                                    //pass doc
                                                                    )
                                                
                                                )
                                                );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              );
            }),
      ),
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
                return const AddKids_screen_1();
              },
            ),
          );
        },
      ),
    );
  }
}
