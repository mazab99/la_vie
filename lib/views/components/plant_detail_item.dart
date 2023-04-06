import 'package:flutter/material.dart';

import 'custom_text.dart';

Widget plantDetialItem({
  required IconData? icon,
  required String value,
  required String description,
}) {
  return Row(
    children: [
      Container(
        height: 60,
        width: 60,
        child: Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
                text: value,
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold),
            customText(text: description, color: Colors.white, fontSize: 15),
          ],
        ),
      )
    ],
  );
}
