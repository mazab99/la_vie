import 'package:flutter/material.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/utils/screen.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:la_vie/views/components/plant_detail_item.dart';
import 'package:la_vie/views/screens/blogs_screens/blogs_screen.dart';

class ScanDetailsScreen extends StatelessWidget {
  const ScanDetailsScreen({Key? key, this.code}) : super(key: key);
  final String? code;

  @override
  Widget build(BuildContext context) {
    Screen(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: Screen.screenHeight / (926 / 391),
              child: Stack(children: [
                Image.asset(
                  "assets/images/plant2.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Screen.screenHeight / (926 / 30),
                      bottom: Screen.screenHeight / (926 / 100),
                      left: Screen.screenWidth / (428 / 40)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      plantDetialItem(
                          icon: Icons.sunny,
                          value: "78%",
                          description: "Sun light"),
                      plantDetialItem(
                          icon: Icons.water_drop_outlined,
                          value: "10%",
                          description: "Water Capacity"),
                      plantDetialItem(
                          icon: Icons.thermostat,
                          value: "29°c",
                          description: "Temperature"),
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: Screen.screenHeight / (926 / 325)),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white),
                child: SizedBox(
                  height: Screen.screenHeight / (926 / (926 - 360)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: Screen.screenWidth / (428 / 30),
                            top: Screen.screenHeight / (926 / 25),
                            bottom: Screen.screenHeight / (926 / 10)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                                text: "SNAKE PLANT (SANSEVIERIA)",
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screen.screenWidth / (428 / 35)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                                text:
                                    "Native to southern Africa, snake plants are well adapted to conditions similar to those in southern regions of the United States. Because of this, they may be grown outdoors for part of all of the year in USDA zones 8 and warmer",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.4,
                                color: AppColors.customGrey)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Screen.screenWidth / (428 / 30),
                            top: Screen.screenHeight / (926 / 20),
                            bottom: Screen.screenHeight / (926 / 10)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                                text: "Common Snake Plant Diseases",
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Screen.screenWidth / (428 / 35)),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: customText(
                                text:
                                    "A widespread problem with snake plants is root rot. This results from over-watering the soil of the plant and is most common in the colder months of the year. When room rot occurs, the plant roots can die due to a lack of oxygen and an overgrowth of fungus within the soil.",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                height: 1.4,
                                color: AppColors.customGrey)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    child: const Text("Go To Blog"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12.0)))),
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const BlogsScreen(),
                      // ));

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BlogsScreen(),
                      ));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
