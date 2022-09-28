import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../reuasblewidgets.dart';

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.25, 20, 0),
          child: Column(
            children: <Widget>[
              imgWidget("assets/images/EarnilyLogo.png", 50, 300),
              Text(
                '!اهلا بك',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.w500),
              ),
              Lottie.network(
                  'https://assets9.lottiefiles.com/packages/lf20_teqgydxl.json')
            ],
          ),
        ),
      ),
    );
  }
}
