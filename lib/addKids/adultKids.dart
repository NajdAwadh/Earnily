import 'dart:math';

import 'package:earnily/api/kidsApi.dart';
import 'package:earnily/models/kids.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../widgets/MainTask.dart';
import 'addkids_screen_1.dart';
import 'dart:ui' as ui;

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

  Color set(String gender) {
    if (gender == "طفلة")
      return Color(0xffff6d6e);
    else
      return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);
    List<Kids> list = kidsNotifier.kidsList;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "الأطفال",
            //textDirection: TextDirection.rtl,
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
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: Container(
                        height: 10,
                        color: Colors
                            .primaries[Random().nextInt(Colors.accents.length)],
                        /*
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        kidsNotifier.kidsList[index].startColor,
                        items[index].endColor
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      boxShadow: [
                        BoxShadow(
                          color: items[index].endColor,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),*/
                        child: new Directionality(
                          textDirection: TextDirection.rtl,
                          child: new GridTile(
                            header: CircleAvatar(
                              backgroundColor:
                                  set(list[index].gender), //Color(0xffff6d6e),
                              foregroundColor: Colors.white,
                              radius: 30,
                              child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Container(
                                    height: 33,
                                    width: 36,
                                    child: Icon(Icons.child_care),
                                  )),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 70),
                                Text(
                                  list[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  list[index].gender,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
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
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              ),
              /*
              // ghada
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
                                  child: Icon(Icons.child_care),
                                )),
                          ),
                          title: Text(
                            kidsNotifier.kidsList[index].name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            kidsNotifier.kidsList[index].gender,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => {},
                          ),
                        ),
                      ));
                },
                itemCount: kidsNotifier.kidsList.length,
              ),
              */

              /*
            child: 
            ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text("test"),
                  title: Text("test"),
                  //subtitle: Text(kidsNotifier.kidsList[index].gender),
                );
              },
              itemCount: 1, //kidsNotifier.kidsList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(color: Colors.black);
              },
            ),*/
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
