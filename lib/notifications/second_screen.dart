import 'package:flutter/material.dart';

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
  backgroundColor: Colors.black,
  elevation: 0,
  title: Text(
    'الانشطة الحالية',
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
