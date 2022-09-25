import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainRewards extends StatefulWidget {
  const MainRewards({super.key});

  @override
  State<MainRewards> createState() => _MainRewardsState();
}

class _MainRewardsState extends State<MainRewards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "المكافأت",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Center(
        child: Text('no rewards added'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          //do something
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
