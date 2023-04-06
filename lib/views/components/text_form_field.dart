import 'package:flutter/material.dart';
import 'package:la_vie/utils/color.dart';

Widget textFormField(
    {TextEditingController? controller,
    required String labelName,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(labelName, style: const TextStyle(color: AppColors.textFieldLabel)),
      const SizedBox(height: 2),
      TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(),
          ),
          validator: validator)
    ],
  );
}
