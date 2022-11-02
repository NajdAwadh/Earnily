import 'dart:math';
import 'dart:ui' as ui;

import 'package:earnily/Rewards/addReward.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../models/AdultReward.dart';
import '../widgets/MainTask.dart';

import 'package:age_calculator/age_calculator.dart';

class MainRewards extends StatefulWidget {
  const MainRewards({super.key});

  @override
  State<MainRewards> createState() => _MainRewardsState();
}

class _MainRewardsState extends State<MainRewards> {
 
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

_showRewardSelected(){

}
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
  
          .collection('users')
      .doc(user.uid)
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
              "مكافآت اطفالي",
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
                      "لا يوجد لديك مكافآت \n قم بالإضافة الآن",
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
                                        size: 50,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        document['rewardName'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        document['points'] + '🌟',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                     IconButton(
                                      icon: Icon(Icons.check),
                                      color: Colors.black,
                                      onPressed: () =>{
                                           /*  if (document['state'] =='pending')
                                                          _showRewardSelected(
                                                               /*  document[
                                                                      'tid'],
                                                                document[
                                                                      'adult'],
                                                                document[
                                                                      'asignedKid'],
                                                                document[
                                                                      'points'] */)
                                                                  else
                                                                    _showDialog2() */
                                             },
                                     )
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
                return const add_Reward();
              },
            ),
          );
        },
      ),
    );
  }
}
