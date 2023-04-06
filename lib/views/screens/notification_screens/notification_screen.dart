import 'package:flutter/material.dart';
import 'package:la_vie/views/components/custom_text.dart';

import '../../../utils/color.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
                padding: EdgeInsets.only(top: 34, bottom: 20),
                child: Text("Notification",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 19))),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Column(children: [
                    ListTile(
                        title: customText(
                            text: "Joy Arnold left 6 comments on Your Post",
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        subtitle: const Text(
                          "Yesterday at 11:42 PM",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        leading: Image.asset(
                          "assets/images/arnold.png",
                          scale: 0.8,
                        )),
                    const Divider(
                      thickness: 0.1,
                      color: AppColors.customGrey,
                    ),
                    ListTile(
                        title: customText(
                            text:
                                "Dennis Nedry commented on Isla Nublar SOC2 compliance report",
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 2,
                                      height: 80,
                                      color: const Color.fromARGB(
                                          255, 202, 201, 201)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: customText(
                                          text:
                                              "“ leaves are an integral part of the stem system. They are attached by a continuous vascular system to the rest of the plant so that free exchange of nutrients.”",
                                          color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Text(
                              "Yesterday at 5:42 PM",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                          ],
                        ),
                        leading: Image.asset(
                          "assets/images/nedry.png",
                          scale: 0.8,
                        )),
                    const Divider(
                      thickness: 0.1,
                      color: AppColors.customGrey,
                    ),
                    ListTile(
                        title: customText(
                            text:
                                "John Hammond created Isla Nublar SOC2 compliance report  ",
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        subtitle: const Text(
                          "Wednesday at 11:15 AM",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14),
                        ),
                        leading: Image.asset(
                          "assets/images/hammond.png",
                          scale: 0.8,
                        )),
                  ]);
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 0.1,
                    color: AppColors.customGrey,
                  );
                },
                itemCount: 3),
          )
        ],
      ),
    );
  }
}
