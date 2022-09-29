// ignore_for_file: prefer_const_constructors, sort_child_properties_last, avoid_print, sized_box_for_whitespace

// import 'package:earnily/google_signin.dart';
import 'package:earnily/pages/home_page.dart';
import 'package:earnily/screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';

import '../reuasblewidgets.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

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
                      'إنشاء عائلة',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "الاسم",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    reuasbleTextField(
                        "الاسم الكامل", Icons.person, false, _nameController),
                    SizedBox(
                      height: 20,
                    ),
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
                        "كلمة المرور",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    reuasbleTextField(
                        "********", Icons.lock, true, _passController),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "إعادة كلمة المرور",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    reuasbleTextField(
                        "********", Icons.lock, true, _repassController),
                    SizedBox(
                      height: 20,
                    ),

                    signInBtn(context, "تسجيل", () async {
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _passController.text.isEmpty ||
                          _repassController.text.isEmpty) {
                        _showDialog();
                      } else if (_passController.text != _repassController.text)
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
                                  builder: (context) => HomePage()));
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        });
                    }),
                    // googleSignUp((){
                    //   final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                    //   provider.googleLogin();
                    // }),
                    signInOption(),
                  ],
                ))),
      ),
    );
  }

//   Widget googleSignUp(Function onTap){
//   return Container(
//     width: MediaQuery.of(context).size.width,
//     height: 100,
//     padding: EdgeInsets.symmetric(vertical: 25),
//     decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//     child: ElevatedButton.icon(
//       onPressed: (){
//         onTap();
//       },
//       icon: FaIcon(FontAwesomeIcons.google , color: Colors.red, ),
//       label: Text(
//       "المتابعة مع Google",
//       style: TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//         fontSize: 20
//       ),
//     ),
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.resolveWith((states) {
//         if(states.contains(MaterialState.pressed)){
//           return Colors.black;
//         }
//         return Colors.black87;
//       }),
//       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//       RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
//     ),
//     )
//     ),
//   );
// }

  Widget signInOption() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInScreen())),
      },
      child: RichText(
        text: TextSpan(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextSpan(
                  text: 'لديك عائلة بالفعل؟',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              TextSpan(
                  text: 'سجل دخول',
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
