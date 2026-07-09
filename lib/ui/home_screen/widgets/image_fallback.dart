import 'dart:math';

import 'package:flutter/material.dart';

class ImageFallback extends StatelessWidget {
  ImageFallback({super.key});

  final random = Random();

  int generateNumber() {
    return random.nextInt(256);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(generateNumber(), generateNumber(),generateNumber(), generateNumber()),
          Colors.transparent
        ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,
        ),
      ),
    );
  }
}
