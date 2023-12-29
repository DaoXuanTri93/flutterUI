

import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  String text;
  double size = 20;
  ButtonStyle? style;
  void Function()? onPressed;
  ButtonScreen({super.key, required this.text, this.style,  this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white, fontSize: size),));
  }
}
