import 'package:flutter/material.dart';
import 'package:la_vie/views/components/custom_text.dart';

import '../../../utils/color.dart';
import '../../../utils/screen.dart';

class ResultNotFound extends StatefulWidget {
  const ResultNotFound({Key? key}) : super(key: key);

  @override
  State<ResultNotFound> createState() => _ResultNotFoundState();
}

class _ResultNotFoundState extends State<ResultNotFound> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Screen.screenWidth / (428 / 24),
            vertical: Screen.screenHeight / (926 / 20)),
        child: Column(
          children: [
            Material(
              elevation: 1,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.secondary,
                ),
                child: const TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.search, color: AppColors.customGrey),
                      hintText: 'Search',
                      border: InputBorder.none),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: const TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                          children: [
                        TextSpan(text: 'Result for  "'),
                        TextSpan(
                            text: "Cactus plant",
                            style: TextStyle(color: AppColors.primary)),
                        TextSpan(text: '"'),
                      ])),
                  const Text(
                    "0 found",
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 129)),
              child: Image.asset("assets/images/notFound.png"),
            ),
            Padding(
              padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 40)),
              child: customText(
                  text: "Not Found", fontWeight: FontWeight.w700, fontSize: 24),
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
    );
  }
}
