
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

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    TaskNotifier taskNotifier =
    Provider.of<TaskNotifier>(context, listen: false);

    getTask(taskNotifier);
    getDates(taskNotifier);

    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  void addToCalendar(String name, DateTime date , String asignedKid , String category , String points) {
    if (selectedDay == date) {
      if (selectedEvents[selectedDay] != null) {
        print('in if');
        selectedEvents[selectedDay]?.add(
          Event(title: name),
        );
      } else {
        print('else');
        selectedEvents[selectedDay] = [Event(title: name)];
      }
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
      addToCalendar(name, date, asignedKid, category, points);
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
          // Expanded(
            
          //   child: ValueListenableBuilder<List<Event>>(
          //     valueListenable: _selectedEvents,
          //     builder: (context, value, _) {
          //       return ListView.builder(
          //         itemCount: value.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: 12.0,
          //               vertical: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //             child: ListTile(
          //               onTap: () => print('${value[index]}'),
          //               title: Text('${value[index]}'),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
                          leading: CircleAvatar(
                           
                            foregroundColor: Colors.white,
                            radius: 30,
                            child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  height: 33,
                                  width: 36,
                                  child: Icon(Icons.text_snippet),
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
                            'test'
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => {

                            },
                          
                        
                      
                
                
              ),
            ),

          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Add Event"),
            content: TextFormField(
              controller: _eventController,
            ),
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  if (_eventController.text.isEmpty) {
                  } else {
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]?.add(
                        Event(title: _eventController.text),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: _eventController.text)
                      ];
                    }
                  }
                  Navigator.pop(context);
                  _eventController.clear();
                  setState(() {});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Event"),
        icon: Icon(Icons.add),
      ),
    );
  }
}