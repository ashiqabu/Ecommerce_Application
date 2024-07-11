import 'package:flutter/material.dart';

Widget kHeight(double height) {
  return SizedBox(
    height: height,
  );
}

Widget kWidth(double width) {
  return SizedBox(
    width: width,
  );
}

Color fillColor = const Color.fromARGB(255, 173, 198, 173);
Color cardColor = const Color.fromARGB(255, 238, 237, 232);
double fontSize = 16;

final List<IconData> iconsList = [
  Icons.person,
  Icons.tv,
  Icons.woman,
];

// final List<String> textList = ['All', 'Favorite', 'Mobile', 'Watch'];
