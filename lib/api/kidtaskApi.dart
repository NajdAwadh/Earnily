import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:earnily/addKids/addkids_screen_1.dart';

getTask(TaskNotifier taskNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('kids')
      .doc('Reema')
      .collection('Task')
      .orderBy('date')
      .get();

  List<Task> _taskList = [];

  snapshot.docs.forEach((document) {
    Task task = Task.fromMap(document.data() as Map<String, dynamic>);
    _taskList.add(task);
  });

  taskNotifier.taskList = _taskList;
}
