// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../reuasblewidgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

Widget buildEmail(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [
      Container(
        alignment: Alignment.centerRight,
        child: Text(
          'البريد الإلكتروني',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
      ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'example@email.com',
              prefixIcon: Icon(
                Icons.email,
              ),
            ) ,
          )
        )
    ],
  );
}

Widget buildPassword(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [ 
      Container(
        alignment: Alignment.centerRight,
        child: Text(
          'كلمة المرور',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
          ),
      ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          child: TextField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '********',
              prefixIcon: Icon(
                Icons.lock,
              ),
            ) ,
          )
        )
    ],
  );
}

Widget buildForgotPassBtn(){
  return Container(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () => print("Forgot Password pressed"),
      // padding: EdgeInsets.only(right: 0),
      child: Text(
        'هل نسيت كلمة المرور؟',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        )
    ),
  );
}

Widget buildLoginBtn(){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
                      onPressed: () => print("login pressed"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ),
                  );
}

Widget buildSignUpBtn(){
  return GestureDetector(
    onTap: () => print("Sing up Pressed") ,
    child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'ليس لديك حساب؟ ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )
          ),
          TextSpan(
            text: 'سجل الان',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )
          )
        ]
      ),
       ),
  );
}

Widget buildJoinBtn(){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 25),
    width: double.infinity,
    child: ElevatedButton(
                      onPressed: () => print("login pressed"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'انضم الى عائلتك',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                        ),
                      ),
                    ),
                  );
}



class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 120,
                ),
                  child: Column(
                    
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    imgWidget("assets/images/earnily.png" , 150 , 50),
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 50),
                    buildEmail(),
                    SizedBox(height: 20),
                    buildPassword(),
                    buildForgotPassBtn(),
                    buildLoginBtn(),
                    buildSignUpBtn(),
                    SizedBox(height: 50),
                    buildJoinBtn(),
                    
                    
                  ],
                ),
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}