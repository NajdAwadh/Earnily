import 'package:flutter/material.dart';

import '../widgets/MainTask.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
    required this.payload,
  }) : super(key: key);

  final String payload;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false,
  actions: <Widget>[
    IconButton(
      icon: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    )
  ],
  backgroundColor: Colors.black,
  elevation: 0,
  title: Text(
    ' النشاط المضاف',
    style: TextStyle(fontSize: 40),
  ),
),

      body: Center(
        child: Text(
          payload,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
