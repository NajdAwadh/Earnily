import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        onDateChanged: (value) => print(value),
        selectedDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 140)),
        lastDate: DateTime.now().add(Duration(days: 10)),
        locale: 'ar',
        backButton: false,
        accent: Colors.black,
      ),
    );
  }
}