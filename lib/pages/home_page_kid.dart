import 'dart:math';

import 'package:earnily/Rewards/kidrewards.dart';
import 'package:earnily/addKids/addkids_screen_1.dart';
import 'package:earnily/addKids/adultsKidProfile.dart';
import 'package:earnily/chatting/chatScreenKid.dart';
import 'package:earnily/pages/KidTasks.dart';
import 'package:earnily/pages/kidWishs.dart';
import 'package:earnily/reuasblewidgets.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:image_picker/image_picker.dart';

import '../Rewards/MainRewards.dart';
import '../screen/profile_screen.dart';
import '../services/upload_file.dart';
import '../widgets/show_picker.dart';

import 'dart:io';

class HomePageKid extends StatefulWidget {
  const HomePageKid({super.key});

  @override
  State<HomePageKid> createState() => _HomePageKidState();
}

class _HomePageKidState extends State<HomePageKid> {
  bool isLoading = false;
  String image = '';
  // final kid = FirebaseAuth.instance.currentUser!;
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  int _selectedIndex = 0;

  void _navigationBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    kidTasks(),
    // kidWish(),
    kidreward(),
    ChatScreenKid(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: imgWidget("assets/images/EarnilyLogo.png", 50, 250),
        ),
        // title: Text(
        //  'E A R N I L Y',
        //  style: TextStyle(fontSize: 35),
        // ),
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.05, 20, 0),
            child: Column(

                //   DrawerHeader(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imgWidget("assets/images/EarnilyLogo.png", 100, 250),
                  Text(
                    user.email!.substring(0, user.email!.indexOf('@')),
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    '________________________________',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                            return const HomePageKid();
                          },
                        ),
                      );
                    },
                  ),
                  Text(
                    '________________________________',
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                  ListTile(
                    title: Text(
                      textAlign: TextAlign.right,
                      'تسجيل الخروج',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SignInScreen();
                          },
                        ),
                      );
                      //do
                    },
                  ),

                  /* child: MaterialButton(
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
            Icons.playlist_add_sharp,
            color: Colors.white,
            size: 35,
          ),
          Icon(
            Icons.star,
            color: Colors.white,
            size: 35,
          ),
          Icon(
            Icons.message_outlined,
            color: Colors.white,
            size: 35,
          ),
        ],
      ), /*
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
      ),*/
    );
  }

  ImagePicker picker = ImagePicker();

  File? file;
  String imageUrl = "";

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    if (pickedFile != null && pickedFile.path != null) {
      loadingTrue();

      file = File(pickedFile.path);
      setState(() {});
      // ignore: use_build_context_synchronously
      imageUrl = await UploadFileServices().getUrl(context, file: file!);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({"image": imageUrl}, SetOptions(merge: true)).then((value) {});
    }
  }

  loadingTrue() {
    isLoading = true;
    setState(() {});
  }

  loadingFalse() {
    isLoading = false;
    setState(() {});
  }
}
