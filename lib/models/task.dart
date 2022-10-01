import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Task {
  late String taskName;
  late String asignedKid;
  late String category;
  late String points;
  late String date;
  late String state;
  late String tid;

  Task.fromMap(Map<String, dynamic> data) {
    taskName = data['taskName'];
    asignedKid = data['asignedKid'];
    category = data['category'];
    points = data['points'];
    date = data['date'];
    state = data['state'];
    tid = data['tid'];
  }
}
