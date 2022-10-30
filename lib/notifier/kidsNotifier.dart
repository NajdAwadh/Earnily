import 'dart:collection';
import 'package:earnily/models/kids.dart';
import 'package:flutter/cupertino.dart';

class KidsNotifier with ChangeNotifier {
  List<Kids> _kidsList = [];
  late Kids _currentKid;
  List<String> _kidsNamesList = [];

  UnmodifiableListView<Kids> get kidsList => UnmodifiableListView(_kidsList);

  
  UnmodifiableListView<String> get kidsNamesList {
    return UnmodifiableListView(_kidsNamesList);
  }
  Kids get currentKid {
    return _currentKid;
  }

  set kidsList(List<Kids> kidsList) {
    _kidsList = kidsList;
    notifyListeners();
  }

  set currentKid(Kids currentKid) {
    _currentKid = currentKid;
    notifyListeners();
  }

  set kidsNamesList(List<String> kidsNamesList) {
    _kidsNamesList = kidsNamesList;
    notifyListeners();
  }
}
