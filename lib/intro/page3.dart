import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class page3 extends StatefulWidget {
  const page3({super.key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
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
              Text(
                'كافئ أطفالك لأنجازاتهم',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_qikc9ips.json')
            ],
          ),
        ),
      ),
    );
  }
}
