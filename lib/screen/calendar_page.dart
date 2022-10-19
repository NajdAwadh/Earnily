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
      appBar: 
      
      CalendarAppBar(
        onDateChanged: (value) => print(value),
        
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365 )),
        selectedDate: DateTime.now(),
        locale: 'ar',
        backButton: true,
        fullCalendar: true,
        accent: Colors.black,
        events: List.generate(
            10, (index) => DateTime.now().subtract(Duration(days: index * 2))),
      ),
    );
  }
}