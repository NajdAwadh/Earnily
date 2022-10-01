import 'dart:collection';
import 'package:earnily/models/kids.dart';
import 'package:flutter/cupertino.dart';

class KidsNotifier with ChangeNotifier {
  List<Kids> _kidsList = [];
  late Kids _currentKid;
  List<String> _kidsNamesList = [];
  late String _kidName;

  UnmodifiableListView<Kids> get kidsList => UnmodifiableListView(_kidsList);
  UnmodifiableListView<String> get kidsNamesList =>
      UnmodifiableListView(_kidsNamesList);
  Kids get currentKid => _currentKid;
  String get kidName => _kidName;

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

  set kidName(String kidName) {
    _kidName = kidName;
    notifyListeners();
  }
}
