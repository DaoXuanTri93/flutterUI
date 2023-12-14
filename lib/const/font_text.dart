import 'package:flutter/material.dart';

class TextFont {
  TextFont._();

  static TextTheme textFont = TextTheme(
    titleLarge: const TextStyle().copyWith(
        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
    titleMedium: const TextStyle().copyWith(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    titleSmall: const TextStyle().copyWith(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
  );

  static TextTheme textButton = TextTheme(
    bodyLarge: const TextStyle().copyWith(
        fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
    bodySmall: const TextStyle().copyWith(
        fontSize: 15, color: Colors.white),
  );

  static TextTheme labelText = TextTheme(
    labelLarge: const TextStyle().copyWith(
        fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
    labelMedium: const TextStyle().copyWith(
        fontSize: 18, fontWeight: FontWeight.w400,color: Colors.black),
    labelSmall: const TextStyle().copyWith(
        fontSize: 15, color: Colors.blue),
  );
}
