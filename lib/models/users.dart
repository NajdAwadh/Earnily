import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  late String email;
  late String family;
  late String firstName;
  late String image;
  late String uid;
  late String token;

  Users({
    required this.email,
    required this.family,
    required this.firstName,
    required this.image,
    required this.uid,
    required this.token,
  });

  Users.fromMap(Map<String, dynamic> data) {
    email = data['email'];
    family = data['family'];
    firstName = data['firstName'];
    image = data['image'];
    uid = data['uid'];
    token = data['token'];
  }

  factory Users.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Users(
      email: snapshot.get('email') ?? "",
      family: snapshot.get('family') ?? "",
      firstName: snapshot.get('firstName') ?? "",
      image: snapshot.get('image') ?? "",
      uid: snapshot.get('uid') ?? "",
      token:snapshot.get('token') ?? "",
    );
  }


}
