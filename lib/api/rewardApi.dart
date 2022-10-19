import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earnily/models/AdultReward.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:earnily/notifier/taskNotifier.dart';
import 'package:earnily/notifier/rewardNotifier.dart';

getReward(RewardNotifier rewardNotifier) async {
  final user = FirebaseAuth.instance.currentUser!;
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('reward')
      .get();

  List<AdultReward> _rewardList = [];

  snapshot.docs.forEach((document) {
    AdultReward adultReward =
        AdultReward.fromMap(document.data() as Map<String, dynamic>);
    _rewardList.add(adultReward);
  });

  rewardNotifier.rewardList = _rewardList;
}
