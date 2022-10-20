import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdultReward {
  late String rewardName;
  late String points;
  late String image;

  AdultReward.fromMap(Map<String, dynamic> data) {
    rewardName = data['rewardName'];
    points = data['points'];
    // image = data['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'rewardName': rewardName, 'points': points,
      // 'image': image
    };
  }
}
