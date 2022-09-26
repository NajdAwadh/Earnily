import 'dart:collection';
import 'package:earnily/models/kids.dart';
import 'package:flutter/cupertino.dart';

class KidsNotifier with ChangeNotifier {
  List<Kids> _kidsList = [];
  late Kids _currentKid;

  UnmodifiableListView<Kids> get kidsList => UnmodifiableListView(_kidsList);
  Kids get currentKid => _currentKid;

  set kidsList(List<Kids> kidsList) {
    _kidsList = kidsList;
    notifyListeners();
  }

  set currentKid(Kids currentKid) {
    _currentKid = currentKid;
    notifyListeners();
  }
}
