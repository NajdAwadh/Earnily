// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace
import 'package:earnily/pages/home_page.dart';
import 'package:earnily/screen/QRreader.dart';
import 'package:earnily/screen/signup_screen.dart';
import 'package:earnily/widgets/new_button.dart';
import 'package:earnily/widgets/new_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../reuasblewidgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
                      'تسجيل الدخول',
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

                    NewText(
                        text: ' كلمة المرور',
                        size: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center),
                    reuasbleTextField(
                        'أدخل كلمة المرور', Icons.lock, true, _passController),
                    SizedBox(
                      height: 10,
                    ),
                    NewText(
                        text: 'هل نسيت كلمة المرور؟',
                        color: Colors.blue,
                        size: 18,
                        fontWeight: FontWeight.w500,
                        onClick: () {}),

                    NewButton(
                        text: 'تسجيل',
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        onClick: () async {
                          if (_emailController.text.isEmpty ||
                              _passController.text.isEmpty) {
                            _showDialog();
                          } else
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim())
                                .then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }).onError((error, stackTrace) {
                              print("error ${error.toString()}");
                            });
                        }),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          flex: 0,
                          child: NewText(
                            text: 'سجل الان',
                            size: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.blue,
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                          ),
                        ),
                        Expanded(
                          // optional flex property if flex is 1 because the default flex is 1
                          flex: 0,
                          child: NewText(
                              text: ' ليس لديك عائلة؟',
                              size: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    NewButton(
                        text: 'انضم الى عائلتك ',
                        width: MediaQuery.of(context).size.width,
                        height: 110,
                        onClick: () {
                          /*
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const QRreader(
                                  title: '',
                                );
                              },
                            ),
                          );*/
                        }),
                  ],
                ))),
      ),
    );
  }
}
