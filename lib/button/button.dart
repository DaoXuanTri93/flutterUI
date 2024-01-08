import 'package:flutter/material.dart';
import '../const/const.dart';

class ButtonScreen extends StatelessWidget {
   ButtonScreen({super.key, required this.onPressed, required this.text, this.radius, this.colors});
   final Function()? onPressed;
   final Widget? text;
   final double? radius;
   final Color? colors;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: text,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.all(15)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder( borderRadius: BorderRadius.circular(5))),
        backgroundColor: MaterialStateProperty.all(colors == null ? Colors.blue : colors),
      ),
    );
  }
}
