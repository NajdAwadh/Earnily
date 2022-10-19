import 'dart:collection';
import 'package:earnily/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis/cloudsearch/v1.dart';

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];
  late Task _currentTask;
  List<String> _currentDateList = [];

  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);
  Task get currentTask => _currentTask;
  UnmodifiableListView<String> get currentDateList =>
      UnmodifiableListView(_currentDateList);

  set taskList(List<Task> taskList) {
    _taskList = taskList;
    notifyListeners();
  }

  set currentKid(Task currentTask) {
    _currentTask = currentTask;
    notifyListeners();
  }

  set currentDateList(List<String> currentDateList) {
    _currentDateList = currentDateList;
    notifyListeners();
  }
}
