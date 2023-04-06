import 'package:flutter/material.dart';

class ForumsType with ChangeNotifier {
  String _pageSelected = "all";

  String get pageSelected => _pageSelected;

  void changePage(String page) {
    _pageSelected = page;
    notifyListeners();
  }
}
