import 'package:flutter/foundation.dart';

class Event {
  final String title;
  final String asignedKid;
  final String category;
  final String points;
  final String tid;
  // final String date;
  // final String state;

  // final String adult;
  Event(
      //this.date, this.state,this.adult,
      {required this.title,
      required this.category,
      required this.points,
      required this.asignedKid,
      required this.tid});

  String toString() => this.title;
}
