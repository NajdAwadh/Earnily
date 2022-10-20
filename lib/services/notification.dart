import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class Notification {

  Future<void> sendNotification (String uID, String message) async {
    final adult =
        await FirebaseFirestore.instance.collection('users').doc(uID).get();

    final String token = adult.get('token');

    if(token == "") {
      Fluttertoast.showToast(
          msg: "Couldn't send notification",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );
      return;
    }



    final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    String key = "";

    key = await getKey() ?? "";

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "key=$key",
    };

    final data = {
      "registration_ids": [token],
      "collapse_key": "type_a",
      "notification": {
        'title': "Task Completed",
        'body': message,
      },
    };

    try{
      final response = await http.post(
          url,
          body: json.encode(data),
          encoding: Encoding.getByName('utf-8'),
          headers: headers
      );

      if (response.statusCode != 200) {
        if (kDebugMode) {
          print(response.body);
        }
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<String?> getKey() async {
    try {
      CollectionReference dataReference = FirebaseFirestore.instance.collection("appData");
      final result = await dataReference.doc("fcmKey").get();

      return result.get("key") as String;
    } on FirebaseException catch (e) {
      final errorMessage = e.toString().split('] ')[1];
      if (kDebugMode) {
        print(e.toString());
      }

      Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 14.0
      );

      return null;
    }
  }
}
