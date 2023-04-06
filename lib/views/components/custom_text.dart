import 'package:flutter/material.dart';

Widget customText({
  required String text,
  Color? color,
  Color? backgroundColor,
  double? fontSize,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  double? letterSpacing,
  double? wordSpacing,
  TextBaseline? textBaseline,
  double? height,
  String? fontFamily,
  TextAlign? textAlign,
  TextDirection? textDirection,
  TextOverflow? overflow,
  int? maxLines,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        backgroundColor: backgroundColor,
        overflow: overflow,
        letterSpacing: letterSpacing,
        height: height),
  );
}
