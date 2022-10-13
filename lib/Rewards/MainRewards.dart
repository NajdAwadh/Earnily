import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:earnily/notifications/local_notification_service.dart';
import 'package:earnily/notifications/second_screen.dart';

import '../reward/addReward.dart';
import '../widgets/MainTask.dart';

class MainRewards extends StatefulWidget {
  const MainRewards({super.key});

  @override
  State<MainRewards> createState() => _MainRewardsState();
}

class _MainRewardsState extends State<MainRewards> {
  late final LocalNotificationService service;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Center(
            child: Text(
              "المكافأت",
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          'لاتوجد مكافأت مضافة',
          style: TextStyle(fontSize: 30, color: Colors.grey),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
            onPressed: () async {
                      Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const add_Reward();
                },
              ),
            );
          },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  /*void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);
  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }*/
}
