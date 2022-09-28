import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class kidWish extends StatefulWidget {
  const kidWish({super.key});

  @override
  State<kidWish> createState() => _kidWishState();
}

class _kidWishState extends State<kidWish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Text(
            "قائمة الامنيات",
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
      body: Center(
        child: Text('لاتوجد امنيات مضافة'),
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
