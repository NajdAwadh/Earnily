import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/AdultReward.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:earnily/api/rewardApi.dart';

import 'dart:ui' as ui;
import 'package:earnily/notifier/rewardNotifier.dart';

class kidreward extends StatefulWidget {
  const kidreward({super.key});

  @override
  State<kidreward> createState() => _kidrewardState();
}
String adultID ='';
int points =0;
String kidName='';
//String rid='';
class _kidrewardState extends State<kidreward> {


  final user = FirebaseAuth.instance.currentUser!;

 
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserDetail();
  
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

  Future<void> deleteReward(String rid) async {
 await FirebaseFirestore.instance
        .collection('users')
        .doc(adultID)
        .collection("reward")
        .doc(rid)
        .delete();
  }

  void _showDialog2( String point  , String rid) async  {
    print(point);
    print(points);
    print(rid);
    int rewardPoint=  int.parse(point);
     print(rewardPoint);
    int kidPoint = points;
   /*  kidPoint= (await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()) as int; */
    if (rewardPoint > kidPoint){
    showDialog(
        context: context,
        builder: (context) {
          // set up the buttons
          Widget cancelButton = TextButton(
            child: Text(
              "حسنا",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            onPressed: Navigator.of(context).pop,
          );
           return AlertDialog(
            title: Text(
              'ليس لديك نقاط كافية للحصول على المكافاة',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            actions: [
              cancelButton,
            ],
          );
        });}
        else{
          showToastMessage('لقد حصلت على المكافاة');
          await FirebaseFirestore.instance
        .collection('kids')
        .doc(kidName+'@gmail.com')
        .update({'points': kidPoint-rewardPoint});

         await FirebaseFirestore.instance
         .collection('users')
         .doc(adultID)
        .collection('kids')
        .doc(kidName+'@gmail.com')
        .update({'points': kidPoint-rewardPoint});
        deleteReward(rid);
        }
  }



void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        backgroundColor: Colors.grey, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 16.0 //message font size
        );
        }
  Widget build(BuildContext context) {
     final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance

          .collection('users')
      .doc(adultID)
      .collection('reward')
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
              "مكافآتي",
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
                  "لا يوجد لديك مكافآت",
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                    ),
                  )
                : Container(
                    child: GridView.builder(
                      itemBuilder: (ctx, index) {
                      Map<String, dynamic> document =
                                                snapshot.data!.docs[index]
                                                        .data()
                                                    as Map<String, dynamic>;
                        return Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(
                                //vertical: 6,
                                //horizontal: 8,
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
                                       Icon(
                                        Icons.card_giftcard,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      SizedBox(height: 10), 
                                      Text(
                                        document['rewardName'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        document['points'] + '🌟',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    /* conButton(
                                        icon: Icon(
                                          Icons.shopping_bag,
                                          size:20,
                                          semanticLabel: "احصل على المكافاه"),
                                          color: Colors.black,
                                            onPressed: () => {
                                              //chack kid point great reward point or not
                                              _showDialog2(document['points'] , document['rid'])
                                  },
                                ), */
                                OutlinedButton.icon(
                                  //color: Colors.black,
                                  onPressed: () => {
                                       //chack kid point great reward point or not
                                      _showDialog2(document['points'] , document['rid'])
                                  },
                                  icon: Icon( // <-- Icon
                                    Icons.shopping_bag,
                                    size: 20.0,
                                    color: Colors.black,
                                            ),
                                    label: Text(
                                      'احصل على المكافاه',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),), // <-- Text
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
        }
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 110,
        child: FittedBox(
          child: FloatingActionButton.extended(
            backgroundColor: Colors.black,
            icon: Icon(
              Icons.wallet,
              size: 30,
            ),
            onPressed: () {
              //
            },
            label: Text('0'),
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
        kidName =snapshot.get('name');
      adultID = snapshot.get("uid");
      points=snapshot.get("points");
       //rid = snapshot.get("rid");
      setState(() {});
      });
      }
}
