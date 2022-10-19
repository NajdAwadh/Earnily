// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, sized_box_for_whitespace

// import 'package:earnily/google_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/kidsignup/kidsignin.dart';
import 'package:earnily/pages/home_page.dart';
import 'package:earnily/pages/home_page_kid.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:earnily/widgets/new_button.dart';
import 'package:earnily/widgets/new_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

import '../reuasblewidgets.dart';

class kidSignUpScreen extends StatefulWidget {
  const kidSignUpScreen({super.key});

  @override
  State<kidSignUpScreen> createState() => _kidSignUpScreenState();
}

class _kidSignUpScreenState extends State<kidSignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _familyController = TextEditingController();

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "حقول الادخال مفقودة",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            content: Text(
              " تأكد من ادخال جميع البيانات من فضلك",
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 20),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text(
                  "حسناً",
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          );
        });
  }

  void _showError() {
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
              'كلمة المرور غير متطابقة',
              textAlign: TextAlign.right,
            ),
          );
        });
  }

  Future addUserDetails(String name, String family, String email) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('kids')
        .doc(firebaseUser.uid)
        .set({
      'firstName': name,
      'family': family,
      'email': email,
      'image': '',
      'uid': firebaseUser.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.01, 20, 0),
                child: Column(
                  children: <Widget>[
                    Container(),
                    imgWidget("assets/images/EarnilyLogo.png", 150, 250),
                    Text(
                      ' كطفل إنشاء عائلة',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    NewText(
                        text: 'الاسم الكامل',
                        size: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: reuasbleTextField(
                                'العائلة',
                                Icons.family_restroom,
                                false,
                                _familyController)),
                        SizedBox(width: 10.0),
                        Expanded(
                            // optional flex property if flex is 1 because the default flex is 1
                            flex: 1,
                            child: reuasbleTextField('الاسم الاول',
                                Icons.person, false, _nameController)),
                      ],
                    ),
                    SizedBox(height: 20),
                    NewText(
                        text: 'البريد الإلكتروني',
                        size: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                    reuasbleTextField("example@email.com", Icons.email, false,
                        _emailController),
                    SizedBox(height: 20),
                    NewText(
                        text: 'كلمة المرور',
                        size: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                    reuasbleTextField(
                        'ادخل كلمة المرور', Icons.lock, true, _passController),
                    SizedBox(height: 20),
                    NewText(
                        text: 'تأكيد كلمة المرور',
                        size: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                    reuasbleTextField('أعد إدخال كلمة المرور', Icons.lock, true,
                        _repassController),
                    SizedBox(height: 20),
                    NewButton(
                        text: 'تسجيل',
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        onClick: () async {
                          if (_nameController.text.isEmpty ||
                              _emailController.text.isEmpty ||
                              _passController.text.isEmpty ||
                              _repassController.text.isEmpty) {
                            _showDialog();
                          } else if (_passController.text !=
                              _repassController.text)
                            _showError();
                          else
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim())
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageKid()));
                            }).onError((error, stackTrace) {
                              print("Error ${error.toString()}");
                            });
                          addUserDetails(
                              _nameController.text.trim(),
                              _familyController.text.trim(),
                              _emailController.text.trim());
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          flex: 0,
                          child: NewText(
                            text: 'سجل دخول',
                            size: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue,
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => kidSignInScreen()));
                            },
                          ),
                        ),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          flex: 0,
                          child: NewText(
                              text: ' لديك عائلة بالفعل؟',
                              size: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ))),
      ),
    );
  }
}
