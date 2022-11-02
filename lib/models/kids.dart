import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Kids {
  late String name;
  late String gender;
  late Timestamp date;
  late String uid;
  late String parentId;
  late String pass;
  late int points;
  late int points2;

  Kids.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    gender = data['gender'];
    date = data['date'];
    uid = data["uid"];
    parentId = data["parentId"];
    pass = data["pass"];
    points = data["points"];
    points2 = data["points2"];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'date': date,
      'parentId': parentId,
      'pass': pass,
      'points': points,
      'points2': points2,
    };
  }
}
