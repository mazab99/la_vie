import 'package:flutter/material.dart';
import 'package:la_vie/utils/color.dart';

Widget answerItem(
    {required String title,
    required int value,
    required int groupValue,
    required void Function(int?)? onChanged}) {
  return ListTile(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: AppColors.primary, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    ),
    trailing: Radio(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: AppColors.primary,
    ),
  );
}
