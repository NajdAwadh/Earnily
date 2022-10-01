import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:earnily/notifier/kidsNotifier.dart';
import 'package:earnily/addKids/addkids_screen_1.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import 'kidsApi.dart';

getTask(TaskNotifier taskNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;
  String kidName = AddKids_screen_1().getKname();
  print(kidName);

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('kids')
      .doc(kidName)
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

getKidName(String name) {
  String nameController = name;

  return nameController;
}
