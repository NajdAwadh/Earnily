// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCreateScreen extends StatefulWidget {
  const QrCreateScreen({super.key});

  @override
  State<QrCreateScreen> createState() => QrCreateScreenState();
}

class QrCreateScreenState extends State<QrCreateScreen> {
  static String qrData = FirebaseAuth.instance.currentUser!.uid;
  String data = "google";
  get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Text(
          '! أمسح الباركود',
          style: TextStyle(fontSize: 40),
        ),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'لأضافة بالغ أخر',
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: QrImage(
              data: qrData,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 300.0,
            ),
          ),
          SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
