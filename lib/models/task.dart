import 'package:flutter/foundation.dart';

class Task {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Task({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
