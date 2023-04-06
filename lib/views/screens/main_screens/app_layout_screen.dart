import 'package:flutter/material.dart';
import 'package:la_vie/provider/all_forums_provider.dart';
import 'package:la_vie/provider/blog_provider.dart';
import 'package:la_vie/provider/bottom_nav_bar.dart';
import 'package:la_vie/provider/cart_provider.dart';
import 'package:la_vie/provider/my_forums_provider.dart';
import 'package:la_vie/provider/product_provider.dart';
import 'package:la_vie/provider/seed_provider.dart';
import 'package:la_vie/provider/tool_provider.dart';
import 'package:la_vie/provider/user_profile_provider.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../../../provider/plant_provider.dart';

class AppLayoutScreen extends StatelessWidget {
  const AppLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavBar>(context, listen: false);
    Provider.of<Seed>(context, listen: false).getAllSeeds();
    Provider.of<Tool>(context, listen: false).getAllTools();
    Provider.of<Plant>(context, listen: false).getAllPlants();
    Provider.of<Product>(context, listen: false).getAllProducts();
    Provider.of<Blog>(context, listen: false).getAllBlogs();
    Provider.of<MyForumsProvider>(context, listen: false).getMyForums();
    Provider.of<AllForumsProvider>(context, listen: false).getAllForums();
    Provider.of<UserProvider>(context, listen: false).getUserData();
    Provider.of<Cart>(context, listen: false)
        .getAllItems(CacheHelper.getData(key: "userId"));
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 10,
        child: CurvedNavigationBar(
          index: Provider.of<BottomNavBar>(context).selectedPage,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.eco_outlined,
                size: 30,
                color: provider.selectedPage == 0 ? Colors.white : null),
            Icon(Icons.qr_code_scanner,
                size: 30,
                color: provider.selectedPage == 1 ? Colors.white : null),
            Icon(Icons.home_outlined,
                size: 30,
                color: provider.selectedPage == 2 ? Colors.white : null),
            Icon(Icons.notifications_none,
                size: 30,
                color: provider.selectedPage == 3 ? Colors.white : null),
            Icon(Icons.perm_identity,
                size: 30,
                color: provider.selectedPage == 4 ? Colors.white : null),
          ],
          color: AppColors.secondary,
          buttonBackgroundColor: const Color(0xff1ABC00),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            provider.changeSelected(index);
          },
          // letIndexChange: (index) => true,
        ),
      ),
      body: provider.pages[Provider.of<BottomNavBar>(context).selectedPage],
    );
  }
}
