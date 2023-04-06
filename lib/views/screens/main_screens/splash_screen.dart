import 'package:flutter/material.dart';
import 'package:la_vie/utils/constants.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/screens/authentication_screens/signup_screen.dart';
import 'package:la_vie/views/screens/main_screens/app_layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Widget widget;
    if (token != null) {
      widget = const AppLayoutScreen();
    } else {
      widget = const SignUpScreen();
    }
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => widget));
    });
  }

  @override
  Widget build(BuildContext context) {
    Screen(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Expanded(
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    "La Vie",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Meddon"),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/1.png',
                  ),
                  heightFactor: 11,
                )
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
