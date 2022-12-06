import 'package:flutter/material.dart';

import '../../shared/styels.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color color;
  final double horizantalValue;
  final double fontSize;
  final Function()? onPressed;
  final double? verticalPadding;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.color,
    required this.horizantalValue,
    required this.fontSize,
    this.verticalPadding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          overlayColor: MaterialStateProperty.all(
              color == Colors.white ? primaryColor : Colors.white60),
          backgroundColor: MaterialStateProperty.all(color),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              horizontal: horizantalValue, vertical: verticalPadding ?? 0.0)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0)))),
      child: Text(text,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: color == Colors.white ? primaryColor : Colors.white)),
    );
  }
}
