import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
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
                'حفز اطفالك لأنجاز مهامهم',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Lottie.network(
                  'https://assets1.lottiefiles.com/packages/lf20_zavtox71.json')
            ],
          ),
        ),
      ),
    );
  }
}
