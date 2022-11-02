import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:earnily/addKids/addkids_screen_1.dart';

getTask(TaskNotifier taskNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('kids')
      .doc(user.email)
      .collection('Task')
      .where('state', isNotEqualTo: 'complete')
      .orderBy('date')
      .get();

  List<Task> _taskList = [];

  snapshot.docs.forEach((document) {
    Task task = Task.fromMap(document.data() as Map<String, dynamic>);
    _taskList.add(task);
  });

  taskNotifier.taskList = _taskList;
}

getCompleteTask(TaskNotifier taskNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('kids')
      .doc(user.email)
      .collection('Task')
      .where('state', isEqualTo: 'complete')
      .orderBy('date')
      .get();

  List<Task> _completeTaskList = [];

  snapshot.docs.forEach((document) {
    Task task = Task.fromMap(document.data() as Map<String, dynamic>);
    _completeTaskList.add(task);
  });

  taskNotifier.completeTaskList = _completeTaskList;
}

getKidName(String name) {
  final user = FirebaseAuth.instance.currentUser!;
  String nameController = name;

  return nameController;
}
