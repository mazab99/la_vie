import 'package:flutter/material.dart';
import 'package:la_vie/views/components/custom_text.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';

class EmptyCartScreen extends StatefulWidget {
  const EmptyCartScreen({Key? key}) : super(key: key);

  @override
  State<EmptyCartScreen> createState() => _EmptyCartScreenState();
}

class _EmptyCartScreenState extends State<EmptyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Screen.screenWidth / (428 / 24),
              vertical: Screen.screenHeight / (926 / 20)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 24)),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: customText(
                    text: "My Cart",
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: Screen.screenHeight / (926 / 125)),
                child: Image.asset("assets/images/notFound.png"),
              ),
              Padding(
                padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 40)),
                child: customText(
                    text: "Your cart is empty",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: Screen.screenHeight / (926 / 12)),
                child: customText(
                    text:
                        "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.customGrey,
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
