import 'dart:collection';
import 'package:earnily/models/task.dart';
import 'package:flutter/cupertino.dart';

class TaskNotifier with ChangeNotifier {
  List<Task> _taskList = [];
  late Task _currentTask;
   List<Task> _completeTaskList = [];

  UnmodifiableListView<Task> get taskList => UnmodifiableListView(_taskList);
  Task get currentTask => _currentTask;
UnmodifiableListView<Task> get completeTaskList => UnmodifiableListView(_completeTaskList);

  set taskList(List<Task> taskList) {
    _taskList = taskList;
    notifyListeners();
  }

  set currentTask(Task currentTask) {
    _currentTask = currentTask;
    notifyListeners();
  }
  set completeTaskList(List<Task> taskList) {
    _completeTaskList = taskList;
    notifyListeners();
  }
}
