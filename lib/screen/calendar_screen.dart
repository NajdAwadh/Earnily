import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 360)),
      lastDate: DateTime.now().add(Duration(days: 360)),
      onDateSelected: (date) => print(date),
      leftMargin: 20,
      monthColor: Colors.black,
      dayColor: Colors.teal[200],
      activeDayColor: Colors.white,
      activeBackgroundDayColor: Colors.black,
      dotsColor: Color(0xFF333A47),
      selectableDayPredicate: (date) => date.day != 23,
      locale: 'ar',
      
    );
  }
}