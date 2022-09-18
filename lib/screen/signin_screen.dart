// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace
import 'package:earnily/pages/home_page.dart';
import 'package:earnily/screen/QRreader.dart';
import 'package:earnily/screen/home_screen.dart';
import 'package:earnily/screen/signup_screen.dart';
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
              "خطأ",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.red),
            ),
            content: Text(
              "ادخل البيانات المطلوبة",
              textAlign: TextAlign.right,
            ),
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
                    20, MediaQuery.of(context).size.height * 0.02, 20, 0),
                child: Column(
                  children: <Widget>[
                    imgWidget("assets/images/mlogo.png", 200, 400),
                    //SizedBox(height: 30),
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "البريد الإلكتروني",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    reuasbleTextField("example@email.com", Icons.email, false,
                        _emailController),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        " كلمة المرور",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    reuasbleTextField(
                        "********", Icons.lock, true, _passController),
                    forgotPassBtn(),
                    signInBtn(context, "تسجيل دخول", () async {
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
                    signUpOption(),
                    SizedBox(height: 30),
                    Text(
                      "أو",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    signInBtn(context, "انضم الى عائلتك", () {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (BuildContext context) {
                            return const QRreader(title: '',);
              },
            ),
          );
                    }),
                  ],
                ))),
      ),
    );
  }

  Widget signUpOption() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpScreen())),
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'ليس لديك عائلة؟ ',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          TextSpan(
              text: 'سجل الان',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))
        ]),
      ),
    );
  }
}
