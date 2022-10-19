import 'package:earnily/Rewards/addReward.dart';
import 'package:earnily/models/AdultReward.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:earnily/notifications/local_notification_service.dart';
import 'package:earnily/notifications/second_screen.dart';

import '../reuasblewidgets.dart';
import '../widgets/MainTask.dart';
import 'package:earnily/notifier/RewardNotifier.dart';
import 'package:earnily/widgets/add_task.dart';
import 'package:flutter/material.dart';
import 'package:earnily/api/taskApi.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:provider/provider.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class MainRewards extends StatefulWidget {
  const MainRewards({super.key});

  @override
  State<MainRewards> createState() => _MainRewardsState();
}

class _MainRewardsState extends State<MainRewards> {
  late final LocalNotificationService service;

  void initState() {
    RewardNotifier rewardNotifier =
        Provider.of<RewardNotifier>(context, listen: false);
    getRewards(rewardNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RewardNotifier rewardNotifier = Provider.of<RewardNotifier>(context);

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
      body: rewardNotifier.rewardList.isEmpty
          ? Center(
              child: Text(
                'لاتوجد مكافأت مضافة',
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
            )
          : Container(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  IconData iconData;
                  Color iconColor;
                  return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child: new Directionality(
                        textDirection: TextDirection.rtl,
                        child: new ListTile(
                          //   leading: CircleAvatar(
                          //     backgroundColor: Colors.white,
                          //     foregroundColor: Colors.white,
                          //     radius: 30,
                          //     child: Padding(
                          //         padding: EdgeInsets.all(6),
                          //         child: Container(
                          //           height: 33,
                          //           width: 36,
                          //           child: IconButton,
                          //         )),

                          title: Text(
                            rewardNotifier.rewardList[index].rewardName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          subtitle: Text(
                            ' 🌟 ${rewardNotifier.rewardList[index].points}',
                            style: TextStyle(fontSize: 20),
                          ),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => {},
                          ),
                        ),
                      ));
                },
                itemCount: rewardNotifier.rewardList.length,
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

  getRewards(RewardNotifier rewardNotifier) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('reward').get();

    List<AdultReward> _rewardList = [];

    snapshot.docs.forEach((document) {
      AdultReward reward =
          AdultReward.fromMap(document.data() as Map<String, dynamic>);
      _rewardList.add(reward);
    });

    rewardNotifier.rewardList = _rewardList;
  }
}
