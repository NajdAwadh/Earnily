import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/kids.dart';
import 'package:earnily/screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:earnily/notifier/kidsNotifier.dart';

getKids(KidsNotifier kidsNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('kids')
      .orderBy('date')
      .get();

  List<Kids> _kidsList = [];

  snapshot.docs.forEach((document) {
    Kids kids = Kids.fromMap(document.data() as Map<String, dynamic>);
    _kidsList.add(kids);
  });

  kidsNotifier.kidsList = _kidsList;
}

getKidsNames(KidsNotifier kidsNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('kids')
      .where(name)
      .get();

  List<String> _kidsNamesList = [];

  snapshot.docs.forEach((document) {
    String name = Kids.fromMap(document.data() as Map<String, dynamic>).name;
    _kidsNamesList.add(name);
  });

  kidsNotifier.kidsNamesList = _kidsNamesList;
}
