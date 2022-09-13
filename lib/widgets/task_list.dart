import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function deleteTx;

  TaskList(this.tasks, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('${tasks[index].amount}'),
                  ),
                ),
              ),
              title: Text(
                tasks[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              subtitle: Text(
                'Due Date: ${DateFormat.yMMMd().format(tasks[index].date)}',
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(tasks[index].id),
              ),
            ),
          );
        },
        itemCount: tasks.length,
      ),
    );
  }
}
