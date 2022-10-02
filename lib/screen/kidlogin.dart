import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../pages/home_page_kid.dart';
import '../reuasblewidgets.dart';
import '../widgets/new_button.dart';

class kidlogin extends StatefulWidget {
  const kidlogin({super.key});

  @override
  State<kidlogin> createState() => _kidloginState();
}

class _kidloginState extends State<kidlogin> {
  final TextEditingController _nameController = TextEditingController();
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
                ),
                reuasbleTextField(
                    "child id", Icons.child_care, false, _nameController),

                NewButton(
                    text: 'تسجيل',
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    onClick: () async {
                      if (_nameController.text.isEmpty) {
                      } else if (_nameController.text == 'reema')
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageKid()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
