import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class kidView extends StatefulWidget {
  const kidView({super.key});

  @override
  State<kidView> createState() => _kidViewState();
}

class _kidViewState extends State<kidView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
