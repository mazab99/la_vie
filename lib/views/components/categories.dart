import 'package:flutter/material.dart';
import 'package:la_vie/utils/color.dart';

Widget categoryWidget({
  required Enum categorySelected,
  required var value,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Material(
      elevation: 0.3,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.secondary,
          border: categorySelected.name == value
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Text(
          "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}",
          style: categorySelected.name == value
              ? const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                )
              : const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.customGrey,
                ),
        ),
      ),
    ),
  );
}
