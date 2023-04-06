import 'package:flutter/material.dart';
import 'package:la_vie/views/screens/forums_screens/discussion_forums_screen.dart';
import 'package:la_vie/views/screens/home_screens/home_screen.dart';
import 'package:la_vie/views/screens/scan_screens.dart/qr_screen.dart';
import 'package:la_vie/views/screens/user_screens/profile_screen.dart';

import '../views/screens/notification_screens/notification_screen.dart';

class BottomNavBar with ChangeNotifier {
  int _selectedPage = 2;

  final List<Widget> _pages = [
    const DiscussionForumsScreen(),
    const QRScreen(),
    const HomeScreen(),
    const NotificationScreen(),
    ProfileScreen()
  ];

  int get selectedPage => _selectedPage;
  List<Widget> get pages => _pages;

  void changeSelected(int x) {
    _selectedPage = x;
    notifyListeners();
  }
}
