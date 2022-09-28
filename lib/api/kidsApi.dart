//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/kids.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:earnily/notifier/kidsNotifier.dart';

getKids(KidsNotifier kidsNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('kids').get();

  List<Kids> _kidsList = [];

  snapshot.docs.forEach((document) {
    Kids kids = Kids.fromMap(document.data() as Map<String, dynamic>);
    _kidsList.add(kids);
  });

  kidsNotifier.kidsList = _kidsList;
}
