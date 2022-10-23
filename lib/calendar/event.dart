import 'package:flutter/foundation.dart';

class Event {
  final String title;
  //final String asignedKid;
  final String category;
  final String points;
  // final String date;
  // final String state;
  // final String tid;
  // final String adult;
  Event(
      {required this.title,
      required this.category,
      //required this.asignedKid,
      required this.points});

  String toString() => this.title;
}
