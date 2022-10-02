import 'dart:math';
import 'dart:ui' as ui;

import 'package:earnily/api/kidsApi.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/kids.dart';
import '../widgets/MainTask.dart';
import 'addkids_screen_1.dart';

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
    KidsNotifier kidsNotifier =
        Provider.of<KidsNotifier>(context, listen: false);
    getKids(kidsNotifier);
    super.initState();
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
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              "الأطفال",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        body: list.isEmpty
            ? Center(
                child: Text(
                  "لا يوجد لديك أطفال \n قم بالإضافة الآن",
                  style: TextStyle(fontSize: 30, color: Colors.grey),
                ),
              )
            : Container(
                child: GridView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 150,
                          color: chooseColor(
                              index), //Colors.primaries[Random().nextInt(myColors.length)],
                          /*
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                              colors: [
                                Colors.primaries[
                                    Random().nextInt(Colors.accents.length)],
                                Colors.primaries[
                                    Random().nextInt(Colors.accents.length)],
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.primaries[
                                  Random().nextInt(Colors.accents.length)],
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        */
                          child: new Directionality(
                            textDirection: TextDirection.rtl,
                            child: new GridTile(
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  imgWidget(set(list[index].gender), 64, 64),
                                  SizedBox(height: 25),
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
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => {},
                          ),
                          */
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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
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
      ),
    );
  }
}

/*
class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
*/