import 'package:flutter/material.dart';

class ForumImage extends StatelessWidget {
  final String image;
  const ForumImage({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Image.network(image))),
    );
  }
}
