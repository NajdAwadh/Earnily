// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace

import 'package:earnily/screen/signin_screen.dart';
import 'package:earnily/widgets/new_button.dart';
import 'package:earnily/widgets/new_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../reuasblewidgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
 void showToastMessage(String message) {
    //raghad
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white,
        //message text color
        fontSize: 16.0 //message font size
        );
  }
  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.deepPurple, fontSize: 20),
            ),
            content: Text(
              " تأكد من ادخال بريد إلكتروني صحيح من فضلك",
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
                    //     imgWidget("assets/images/mlogo.png", 200, 400),
                    imgWidget("assets/images/EarnilyLogo.png", 150, 250),
                    //SizedBox(height: 30),
                    Text(
                      'إعادة كلمة المرور',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),

                    NewText(
                        text: 'البريد الإلكتروني',
                        size: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                    reuasbleTextField("example@email.com", Icons.email, false,
                        _emailController),
                    SizedBox(height: 20),

                    
                    

                    NewButton(
                        text: 'إرسال',
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        onClick: () async {
                          if (_emailController.text.isEmpty 
                              ) {
                            _showDialog();
                          } else
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: _emailController.text)
                                
                                .then((value) {
                                  
                                  showToastMessage('تم الارسال بنجاح');

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            }
                            ).onError((error, stackTrace) {
                              // showToastMessage('خطأ ${error.toString()}');
                              _showDialog();
                              print("error ${error.toString()}");
                            });
                        }),

                    

                    

                    

                   
                  ],
                ))),
      ),
    );
  }
}

//can u see me