import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Kids {
  late String name;
  late String gender;
  late Timestamp date;
  late String point;
  late String uid;
  late String pass;

  List<String> kidsNamesList = [];

  Kids();

  Kids.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    gender = data['gender'];
    date = data['date'];
    point = data['point'];
    uid = data["uid"];
    pass = data["pass"];
  }
  getKids() async {
    final user = FirebaseAuth.instance.currentUser!;
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('kids')
        .where(name)
        .get();


    snapshot.docs.forEach((document) {
      String name = Kids.fromMap(document.data() as Map<String, dynamic>).name;
      kidsNamesList.add(name);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender,
      'date': date,
      'point': point,
      'uid': uid,
      'pass': pass,
    };
  }
}
