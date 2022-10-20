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
  final kidsDb = FirebaseFirestore.instance.collection('kids');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KidsNotifier kidsNotifier =
        Provider.of<KidsNotifier>(context, listen: false);
    getKids(kidsNotifier);
  }

/*
  void profile() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              text,
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text("حسناً"),
              )
            ],
          );
        });
  }
*/

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
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);
    List<Kids> list = kidsNotifier.kidsList;

    Future<void> _refreshList() async {
      getKids(kidsNotifier);
    }

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
        child: list.isEmpty
            ? Center(
                child: Text(
                  "لا يوجد لديك أطفال \n قم بالإضافة الآن",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
              )
            : Container(
                child: GridView.builder(
                  itemBuilder: (ctx, index) {
                    list = kidsNotifier.kidsList;
                    return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        child: Container(
                          height: 150,
                          color: chooseColor(
                              index), //Colors.primaries[Random().nextInt(myColors.length)],

                          child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: new GridTile(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  imgWidget(set(list[index].gender), 64, 64),
                                  SizedBox(height: 15),
                                  Text(
                                    list[index].name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  //SizedBox(height: 15),
                                  /*
                                Text(
                                  list[index].date.toString(),
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                */
/*
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Theme.of(context).errorColor,
                                    onPressed: () => {list[index]},
                                  ),
*/

                                  IconButton(
                                    icon: Icon(Icons.account_circle_sharp),
                                    color: Colors.black,
                                    iconSize: 40,
                                    onPressed: () {
                                      kidsNotifier.currentKid =
                                          kidsNotifier.kidsList[index];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdultsKidProfile()));
                                      /*
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              icon: imgWidget(
                                                  set(list[index].gender),
                                                  64,
                                                  64),
                                              title: Text(
                                                list[index].name +
                                                    '\n' +
                                                    list[index].pass,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              content: Text(
                                                getBirthday(list[index].date)
                                                    .toString(),
                                                textAlign: TextAlign.right,
                                              ),
                                              actions: <Widget>[
                                                IconButton(
                                                  icon: Icon(Icons.delete),
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  onPressed: () => {
                                                    kidsDb
                                                        .doc(kidsNotifier
                                                            .currentKid
                                                            .toString())
                                                        .delete()
                                                  },
                                                ),
                                              ],
                                            );
                                          });*/
                                    },
                                  ),
                                  /*
                                  InkWell(
                                    onTap: () {
                                      kidsNotifier.currentKid =
                                          kidsNotifier.kidsList[index];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdultsKidProfile()));
                                    },
                                    */
                                  //),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                  itemCount: kidsNotifier.kidsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                ),
              ),
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
