import 'dart:math';
import 'dart:ui' as ui;

import 'package:earnily/api/kidsApi.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:earnily/pages/home_page_kid.dart';
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
      return "assets/images/boyIcon.png";
  }

  List<Color> myColors = [
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

  @override
  Widget build(BuildContext context) {
    KidsNotifier kidsNotifier = Provider.of<KidsNotifier>(context);
    List<Kids> list = kidsNotifier.kidsList;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "الأطفال",
            textAlign: TextAlign.center,
            //textDirection: TextDirection.rtl,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: kidsNotifier.kidsList.isEmpty
          ? Center(
              child: Text(
                "لا يوجد لديك أطفال \n قم بالإضافة الآن",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )
          : GestureDetector(
            onTap: () {
              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageKid()));
            },
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
                        color: Color(0xffff6d6e), //Colors.primaries[Random().nextInt(myColors.length)]

                        //color: Colors.primaries[ Random().nextInt(myColors.length)],
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(24),
                        //   gradient: LinearGradient(
                        //       colors: [
                        //         Colors.primaries[
                        //             Random().nextInt(Colors.accents.length)],
                        //         Colors.primaries[
                        //             Random().nextInt(Colors.accents.length)],
                        //       ],
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight),
                        //   boxShadow: [
                        //     BoxShadow(
                        //       color: Colors.primaries[
                        //           Random().nextInt(Colors.accents.length)],
                        //       blurRadius: 12,
                        //       offset: Offset(0, 6),
                        //     ),
                        //   ],
                        // ),
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
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
              ),
            ),
      // Container(
      //     // ghada

      //     child: GridView.builder(
      //       itemBuilder: (ctx, index) {
      //         return Card(
      //             elevation: 5,
      //             margin: EdgeInsets.symmetric(
      //               vertical: 8,
      //               horizontal: 5,
      //             ),
      //             child: new Directionality(
      //               textDirection: TextDirection.rtl,
      //               child: new ListTile(
      //                 leading: CircleAvatar(
      //                   backgroundColor: Color(0xffff6d6e),
      //                   foregroundColor: Colors.white,
      //                   radius: 30,
      //                   child: Padding(
      //                       padding: EdgeInsets.all(6),
      //                       child: Container(
      //                         height: 33,
      //                         width: 36,
      //                         child: Icon(Icons.child_care),
      //                       )),
      //                 ),
      //                 title: Text(
      //                   kidsNotifier.kidsList[index].name,
      //                   style: TextStyle(
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 22,
      //                   ),
      //                 ),
      //                 subtitle: Text(
      //                   kidsNotifier.kidsList[index].gender,
      //                 ),
      //                 trailing: IconButton(
      //                   icon: Icon(Icons.delete),
      //                   color: Theme.of(context).errorColor,
      //                   onPressed: () => {},
      //                 ),
      //               ),
      //             ));
      //       },
      //       itemCount: kidsNotifier.kidsList.length,
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 2),
      //     ),

      //     /*
      //   child:
      //   ListView.separated(
      //     itemBuilder: (BuildContext context, int index) {
      //       return ListTile(
      //         leading: Text("test"),
      //         title: Text("test"),
      //         //subtitle: Text(kidsNotifier.kidsList[index].gender),
      //       );
      //     },
      //     itemCount: 1, //kidsNotifier.kidsList.length,
      //     separatorBuilder: (BuildContext context, int index) {
      //       return Divider(color: Colors.black);
      //     },
      //   ),*/
      //   ),

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