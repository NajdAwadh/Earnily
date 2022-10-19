import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Kids {
  late String name;
  late String gender;
  late Timestamp date;
  late String uid;
  late String pass;

  Kids.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    gender = data['gender'];
    date = data['date'];
    uid = data["uid"];
    pass = data["pass"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'date': date,
      'uid': uid,
      'pass': pass,
    };
  }
}
