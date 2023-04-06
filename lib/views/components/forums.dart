import 'package:flutter/material.dart';
import 'package:la_vie/provider/forums.dart';
import 'package:la_vie/utils/color.dart';
import 'package:la_vie/views/components/custom_text.dart';
import 'package:provider/provider.dart';

Widget forumsType({
  required String type,
  required BuildContext context,
}) {
  var provider = Provider.of<ForumsType>(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  type == provider.pageSelected
                      ? AppColors.primary
                      : Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)))),
          onPressed: () {
            Provider.of<ForumsType>(context, listen: false).pageSelected !=
                    "all"
                ? Provider.of<ForumsType>(context, listen: false)
                    .changePage("all")
                : null;
          },
          child: customText(
              text: "All Forums",
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: type == provider.pageSelected
                  ? Colors.white
                  : AppColors.customGrey)),
      const SizedBox(width: 10),
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  type == provider.pageSelected
                      ? Colors.white
                      : AppColors.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: type == provider.pageSelected
                              ? AppColors.customGrey
                              : AppColors.primary,
                          width: 1)))),
          onPressed: () {
            Provider.of<ForumsType>(context, listen: false).pageSelected ==
                    "all"
                ? Provider.of<ForumsType>(context, listen: false)
                    .changePage("myForums")
                : null;
          },
          child: customText(
              text: "My Forums",
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: type == provider.pageSelected
                  ? AppColors.customGrey
                  : Colors.white)),
    ],
  );
}
