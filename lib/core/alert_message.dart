import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(message),
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}
