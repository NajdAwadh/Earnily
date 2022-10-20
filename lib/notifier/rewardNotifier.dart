import 'dart:collection';
import 'package:earnily/models/AdultReward.dart';
import 'package:flutter/cupertino.dart';

class RewardNotifier with ChangeNotifier {
  List<AdultReward> _rewardList = [];
  late AdultReward _currentReward;

  UnmodifiableListView<AdultReward> get rewardList =>
      UnmodifiableListView(_rewardList);
  AdultReward get currentReward => _currentReward;

  set rewardList(List<AdultReward> rewardList) {
    _rewardList = rewardList;
    notifyListeners();
  }

  set currentReward(AdultReward currentReward) {
    _currentReward = _currentReward;
    notifyListeners();
  }
}
