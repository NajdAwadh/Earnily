import 'package:flutter/foundation.dart';

class Task {
  final String id;
  final String title;
  final String kid;
  final String category;
  final double amount;
  final DateTime date;

  Task({
    @required this.id,
    @required this.title,
    @required this.kid,
    @required this.category,
    @required this.amount,
    @required this.date,
  });
}
