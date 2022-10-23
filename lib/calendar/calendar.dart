import 'package:earnily/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/driveactivity/v2.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../api/taskApi.dart';
import '../models/task.dart';
import '../notifier/taskNotifier.dart';
import 'event.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:ui' as ui;

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late Map<DateTime, List<Event>> selectedEvents;

  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final formatter = DateFormat('yMd');
  List<Task> list = [];
  String category = '';
  late IconData iconData;
  late Color iconColor;

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    getTask(taskNotifier);
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  void addToCalendar(String name, DateTime date, String asignedKid,
      String category, String points, Task task) {
    if (selectedDay == date) {
      list.add(task);
      if (selectedEvents[selectedDay] != null) {
        print('in if');
        selectedEvents[selectedDay]
            ?.add(Event(title: name, category: category, points: points));
      } else {
        print('else');
        selectedEvents[selectedDay] = [
          Event(title: name, category: category, points: points)
        ];
      }
    }
  }

  void color(String category) {
    switch (category) {
      case "النظافة":
        iconData = Icons.wash;

        iconColor = Color(0xffff6d6e);
        break;
      case "الأكل":
        iconData = Icons.flatware_rounded;
        iconColor = Color(0xfff29732);
        break;

      case "الدراسة":
        iconData = Icons.auto_stories_outlined;
        iconColor = Color(0xff6557ff);
        break;

      case "تطوير الشخصية":
        iconData = Icons.border_color_outlined;
        iconColor = Color(0xff2bc8d9);
        break;

      case "الدين":
        iconData = Icons.brightness_4_rounded;
        iconColor = Color(0xff234ebd);
        break;
      default:
        iconData = Icons.brightness_4_rounded;
        iconColor = Color(0xff6557ff);
    }
  }

  void add(List<Task> tasks) {
    for (var i = 0; i < tasks.length; i++) {
      String name = tasks[i].taskName;
      String asignedKid = tasks[i].asignedKid;
      String category = tasks[i].category;
      String points = tasks[i].points;

      DateTime date = formatter.parseUTC(tasks[i].date);

      _getEventsfromDay(date);
      addToCalendar(name, date, asignedKid, category, points, tasks[i]);
    }
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar');
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    List<Task> task = taskNotifier.taskList;

    add(task);

    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            locale: 'ar',
            availableCalendarFormats: const {
              CalendarFormat.month: 'شهر',
              CalendarFormat.twoWeeks: 'أسبوعين',
              CalendarFormat.week: 'أسبوع',
            },
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
                selectedEvents.clear();
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),

            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) =>
                /*Container(
              child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    IconData iconData;
                    Color iconColor;
                    switch (event.category) {
                      case "النظافة":
                        iconData = Icons.wash;

                        iconColor = Color(0xffff6d6e);
                        break;
                      case "الأكل":
                        iconData = Icons.flatware_rounded;
                        iconColor = Color(0xfff29732);
                        break;

                      case "الدراسة":
                        iconData = Icons.auto_stories_outlined;
                        iconColor = Color(0xff6557ff);
                        break;

                      case "تطوير الشخصية":
                        iconData = Icons.border_color_outlined;
                        iconColor = Color(0xff2bc8d9);
                        break;

                      case "الدين":
                        iconData = Icons.brightness_4_rounded;
                        iconColor = Color(0xff234ebd);
                        break;
                      default:
                        iconData = Icons.brightness_4_rounded;
                        iconColor = Color(0xff6557ff);
                    }
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: new Directionality(
                        textDirection: ui.TextDirection.rtl,
                        child: new ListTile(
                          leading: CircleAvatar(
                            backgroundColor: iconColor,
                            foregroundColor: Colors.white,
                            radius: 30,
                            child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  height: 33,
                                  width: 36,
                                  child: Icon(iconData),
                                )),
                          ),
                          title: Text(
                            event.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            event.points,
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: selectedEvents.length),
            ),*/

                Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: new Directionality(
                textDirection: ui.TextDirection.rtl,
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: new Directionality(
                        textDirection: ui.TextDirection.rtl,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Container(
                              height: 33,
                              width: 36,
                              child: Icon(Icons.text_snippet),
                            ))),
                  ),
                  title: new Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Text(
                      event.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  //subtitle: Text('test'),
                  /*
              isThreeLine: true,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => {},
              ),*/
                ),
              ),
            ),
          ),
          /*
          IconData iconData;
                    Color iconColor;
                    switch (event.category) {
                      case "النظافة":
                        iconData = Icons.wash;

                        iconColor = Color(0xffff6d6e);
                        break;
                      case "الأكل":
                        iconData = Icons.flatware_rounded;
                        iconColor = Color(0xfff29732);
                        break;

                      case "الدراسة":
                        iconData = Icons.auto_stories_outlined;
                        iconColor = Color(0xff6557ff);
                        break;

                      case "تطوير الشخصية":
                        iconData = Icons.border_color_outlined;
                        iconColor = Color(0xff2bc8d9);
                        break;

                      case "الدين":
                        iconData = Icons.brightness_4_rounded;
                        iconColor = Color(0xff234ebd);
                        break;
                      default:
                        iconData = Icons.brightness_4_rounded;
                        iconColor = Color(0xff6557ff);
          
          Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: new Directionality(
                textDirection: ui.TextDirection.rtl,
                child: ListTile(
                  leading: CircleAvatar(
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: new Directionality(
                        textDirection: ui.TextDirection.rtl,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Container(
                              height: 33,
                              width: 36,
                              child: Icon(Icons.text_snippet),
                            ))),
                  ),
                  title: new Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Text(
                      event.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  //subtitle: Text('test'),
                  /*
              isThreeLine: true,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => {},
              ),*/
                ),
              ),
            ),
            */
        ],
      ),
    );
  }
}
