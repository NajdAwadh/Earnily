import 'dart:collection';
import 'package:earnily/models/task.dart';
import 'package:flutter/cupertino.dart';

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];
  late Task _currentTask;

  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);
  Task get currentTask => _currentTask;

  set taskList(List<Task> taskList) {
    _taskList = taskList;
    notifyListeners();
  }

  set currentTask(Task currentTask) {
    _currentTask = currentTask;
    notifyListeners();
  }
}
