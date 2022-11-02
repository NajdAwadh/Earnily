import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdultReward {
  late String rewardName;
  late String points;
  late String image;
  late String rid;

  AdultReward.fromMap(Map<String, dynamic> data) {
    rewardName = data['rewardName'];
    points = data['points'];
    rid = data['rid'];
    // image = data['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rewardName': rewardName, 'points': points,'rid': rid,
      // 'image': image
    };
  }
}
