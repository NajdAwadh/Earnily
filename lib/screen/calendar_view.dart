import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: WeekView(),
    );
  }
}