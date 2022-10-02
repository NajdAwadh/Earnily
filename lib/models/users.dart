import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  late String email;
  late String family;
  late String firstName;
  late String image;
  late String uid;

  Users.fromMap(Map<String, dynamic> data) {
    email = data['email'];
    family = data['family'];
    firstName = data['firstName'];
    image = data['image'];
    uid = data['uid'];
  }
}
