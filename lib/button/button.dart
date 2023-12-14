import 'package:flutter/material.dart';
import '../const/const.dart';

class ButtonScreen extends StatelessWidget {
   ButtonScreen({super.key, required this.onPressed, required this.text, this.radius});
   final Function()? onPressed;
   final Widget? text;
   final double? radius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: text,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(radius??0))));
  }
}
