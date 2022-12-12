import 'dart:io';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/addKids/adultsKidProfile.dart';
import 'package:earnily/chatting/chatScreenKid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'ChatScreen.dart';

late User signedInUser;
final firebase = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;
String childName = '';
String name = '';
List<String> list = [];
//List<String> uidList = [];
String uid = '';
String myId = '';

void _CircularProgressIndicator() {
  CircularProgressIndicator(
    value: null,
  );
}

void getCurrentUser() {
  try {
    final user = auth.currentUser;
    if (user != null) {
      signedInUser = user;
      myId = signedInUser.uid;
      print(signedInUser.uid);
    }
  } catch (e) {
    print('fail to log in');
  }
}

void kidsStream() async {
  await for (var snapshot in firebase
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('kids')
      .snapshots()) {
    for (var kid in snapshot.docs) {
      //print(kid.data());
      list.add(kid.get('name'));
    }
    for (var i = 0; i < list.length; i++) {
      print(list[i]);
    }
  }
}

class chooseKid extends StatefulWidget {
  const chooseKid({super.key});

  @override
  State<chooseKid> createState() => _chooseKidState();
}

class _chooseKidState extends State<chooseKid> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    kidsStream();
  }

  _validate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ChatScreen(); //QrCreateScreen("اضافة طفل");
        },
      ),
    );
  }

  String set(String gender) {
    if (gender == "طفلة")
      return "assets/images/girlIcon.png";
    else
      return "assets/images/boyIcon.png";
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
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('kids')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Center(
          child: Text(
            'محادثة',
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: new Directionality(
        textDirection: ui.TextDirection.rtl,
        child: SafeArea(
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamBuilder(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "لا يوجد لديك أطفال \n قم بالإضافة الآن",
                          style: TextStyle(fontSize: 30, color: Colors.grey),
                        );
                      }
                      return GridView.builder(
                        itemBuilder: (contex, index) {
                          Map<String, dynamic> document =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

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
                                        //imgWidget(set(document['gender']), 64, 64),
                                        Text(
                                          document['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.message_outlined),
                                          color: Colors.black,
                                          iconSize: 40,
                                          onPressed: () {
                                            childName = document['name'];

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        AdultsKidProfile(
                                                            document: document,
                                                            id: FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                            //pass doc
                                                            )));
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
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8),
                      );
                    }),

                /*
                Center(
                  child: Container(
                      alignment: Alignment.topRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButtonFormField<String>(
                          hint: childName.isEmpty
                              ? Text("الطفل")
                              : Text(childName),
                          isExpanded: true,
                          alignment: Alignment.centerRight,
                          validator: (val) {
                            if (val == null) return "اختر الطفل";
                            return null;
                          },
                          items: list.map((valueItem) {
                            return DropdownMenuItem(
                              alignment: Alignment.centerRight,
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              childName = newVal!;
                            });
                          })),
                ),
                */
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(
                        width: 0,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  onPressed: _validate,
                  child: const Text('إضافة ',
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
