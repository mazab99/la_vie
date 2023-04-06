import 'package:flutter/material.dart';
import 'package:la_vie/views/screens/home_screens/home_screen.dart';

class Categories with ChangeNotifier {
  var _categorySelected = Category.all;

  Category get selectedCategory => _categorySelected;

  void changeSelectedCategory(Category cat) {
    _categorySelected = cat;
    notifyListeners();
  }
}
