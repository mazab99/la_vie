import 'package:flutter/material.dart';
import 'package:la_vie/provider/all_forums_provider.dart';
import 'package:la_vie/provider/authentication_provider.dart';
import 'package:la_vie/provider/blog_provider.dart';
import 'package:la_vie/provider/bottom_nav_bar.dart';
import 'package:la_vie/provider/cart_provider.dart';
import 'package:la_vie/provider/categories.dart';
import 'package:la_vie/provider/forums.dart';
import 'package:la_vie/provider/my_forums_provider.dart';
import 'package:la_vie/provider/plant_provider.dart';
import 'package:la_vie/provider/product_provider.dart';
import 'package:la_vie/provider/qr.dart';
import 'package:la_vie/provider/question_provider.dart';
import 'package:la_vie/provider/seed_provider.dart';
import 'package:la_vie/provider/tool_provider.dart';
import 'package:la_vie/provider/user_profile_provider.dart';
import 'package:la_vie/services/cashe_helper.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/views/screens/main_screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  // CacheHelper.setData(
  //     key: "token",
  //     value:
  //         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI4YjFlNjdlYy1mZmE0LTRjYzItYjJjZi1kZDBjNDliM2E5ZjgiLCJpYXQiOjE2NjI3NzA5ODYsImV4cCI6MTY2Mjk0Mzc4Nn0.nL2mgCfJRGDUHhc1lXNA-A5p2KUFRdS7Yl4VIYnfWHA");
  token = CacheHelper.getData(key: "token");

  if (CacheHelper.getData(key: "userPoints") != null) {
    points = CacheHelper.getData(key: "userPoints");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Authentication>(create: (_) => Authentication()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<Seed>(create: (_) => Seed()),
        ChangeNotifierProvider<Tool>(create: (_) => Tool()),
        ChangeNotifierProvider<Plant>(create: (_) => Plant()),
        ChangeNotifierProvider<Product>(create: (_) => Product()),
        ChangeNotifierProvider<Blog>(create: (_) => Blog()),
        ChangeNotifierProvider<AllForumsProvider>(
            create: (_) => AllForumsProvider()),
        ChangeNotifierProvider<MyForumsProvider>(
            create: (_) => MyForumsProvider()),
        ChangeNotifierProvider<Categories>(create: (_) => Categories()),
        ChangeNotifierProvider<BottomNavBar>(create: (_) => BottomNavBar()),
        ChangeNotifierProvider<ForumsType>(create: (_) => ForumsType()),
        ChangeNotifierProvider<Question>(create: (_) => Question()),
        ChangeNotifierProvider<QR>(create: (_) => QR()),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const SplashScreen()),
    );
  }
}
